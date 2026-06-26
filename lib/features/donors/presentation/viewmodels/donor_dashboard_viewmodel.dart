import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vital_match/core/enums/alert_response_status.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/core/enums/alert_status.dart';
import 'package:vital_match/core/enums/notification_type.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/reward/domain/entities/reward.dart';
import 'package:vital_match/features/users/domain/entities/app_user.dart';

class DonorDashboardViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isUpdatingAvailability = false;
  String? errorMessage;

  AppUser? currentUser;
  Donor? donor;
  List<DonationRecord> donationRecords = [];
  List<EmergencyAlert> emergencyAlerts = [];
  List<Reward> rewards = [];
  final Map<String, Hospital> hospitalsById = {};
  final Set<String> respondedAlertIds = {};

  Future<void> loadDashboard() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      currentUser = await ServiceLocator.getUserByIdUsecase(uid);

      donor = await ServiceLocator.getDonorUsecase(uid);

      final allRecords = await ServiceLocator.getAllDonationRecordsUsecase();

      donationRecords =
          allRecords.where((record) => record.donorId == uid).toList()..sort(
            (first, second) =>
                second.donationDate.compareTo(first.donationDate),
          );

      rewards = await ServiceLocator.getRewardsByDonorUsecase(uid);

      final allAlerts = await ServiceLocator.getAllEmergencyAlertsUsecase();

      final activeAlerts = allAlerts
          .where((alert) => alert.status == AlertStatus.active)
          .toList();

      for (final alert in activeAlerts) {
        if (hospitalsById.containsKey(alert.hospitalId)) {
          continue;
        }

        try {
          hospitalsById[alert.hospitalId] =
              await ServiceLocator.getHospitalUsecase(alert.hospitalId);
        } catch (e) {
          debugPrint('LOAD ALERT HOSPITAL FAILED: $e');
        }
      }

      emergencyAlerts =
          activeAlerts
              .where(
                (alert) =>
                    alert.bloodGroup == donor?.bloodGroup &&
                    _distanceToAlert(alert) <= alert.radiusKm,
              )
              .toList()
            ..sort(
              (first, second) => second.createdAt.compareTo(first.createdAt),
            );

      await _loadAlertResponses(uid);
    } catch (e) {
      errorMessage = 'Failed to load donor dashboard.';
      debugPrint('LOAD DONOR DASHBOARD FAILED: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleAvailability(bool value) async {
    final currentDonor = donor;

    if (currentDonor == null) {
      return;
    }

    isUpdatingAvailability = true;
    notifyListeners();

    try {
      await ServiceLocator.updateDonorAvailabilityUsecase(
        donorId: currentDonor.donorId,
        isAvailable: value,
      );

      donor = Donor(
        donorId: currentDonor.donorId,
        userId: currentDonor.userId,
        bloodGroup: currentDonor.bloodGroup,
        weight: currentDonor.weight,
        gpsLatitude: currentDonor.gpsLatitude,
        gpsLongitude: currentDonor.gpsLongitude,
        age: currentDonor.age,
        pointsBalance: currentDonor.pointsBalance,
        isAvailable: value,
        isVerified: currentDonor.isVerified,
        dateOfBirth: currentDonor.dateOfBirth,
        createdAt: currentDonor.createdAt,
        lastDonationDate: currentDonor.lastDonationDate,
      );
    } catch (e) {
      errorMessage = 'Failed to update availability.';
      debugPrint('UPDATE DONOR AVAILABILITY FAILED: $e');
    } finally {
      isUpdatingAvailability = false;
      notifyListeners();
    }
  }

  Future<void> respondToEmergencyAlert(
    EmergencyAlert alert,
    AlertResponseStatus status,
  ) async {
    final currentDonor = donor;

    if (currentDonor == null) {
      return;
    }

    try {
      final responseId = '${alert.alertId}_${currentDonor.donorId}';
      final responseRef = FirebaseFirestore.instance
          .collection('alert_responses')
          .doc(responseId);

      final existingResponse = await responseRef.get();

      if (existingResponse.exists) {
        respondedAlertIds.add(alert.alertId);
        notifyListeners();
        return;
      }

      await responseRef.set({
        'responseId': responseId,
        'alertId': alert.alertId,
        'donorId': currentDonor.donorId,
        'responseStatus': status.name,
        'responseDate': DateTime.now().toIso8601String(),
      });

      final notificationRef = FirebaseFirestore.instance
          .collection('notifications')
          .doc();

      await notificationRef.set({
        'userId': alert.technicianId,
        'alertId': alert.alertId,
        'type': NotificationType.alertResponse.name,
        'title': 'Emergency alert response',
        'message': status == AlertResponseStatus.accepted
            ? '${currentUser?.fullName ?? 'A donor'} accepted your emergency alert. Phone: ${currentUser?.phoneNumber ?? 'Not available'}.'
            : '${currentUser?.fullName ?? 'A donor'} rejected your emergency alert.',
        'isRead': false,
        'sentAt': Timestamp.now(),
        'channel': 'push',
        'deepLink': 'vitalmatch://lab/emergency-alerts/${alert.alertId}',
        'actions': ['open'],
      });

      respondedAlertIds.add(alert.alertId);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to respond to alert.';
      debugPrint('RESPOND TO ALERT FAILED: $e');
      notifyListeners();
    }
  }

  Future<void> _loadAlertResponses(String donorId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('alert_responses')
        .where('donorId', isEqualTo: donorId)
        .get();

    respondedAlertIds
      ..clear()
      ..addAll(
        snapshot.docs
            .map((doc) => doc.data()['alertId'] as String?)
            .whereType<String>(),
      );
  }

  int get totalDonations {
    return donationRecords.length;
  }

  double get litersDonated {
    return donationRecords.fold<double>(
      0,
      (total, record) => total + record.bloodUnitsCollected * 0.45,
    );
  }

  int get lifetimePoints {
    final currentDonor = donor;

    if (currentDonor != null && currentDonor.pointsBalance > 0) {
      return currentDonor.pointsBalance;
    }

    return donationRecords.fold<int>(
      0,
      (total, record) => total + record.pointsAwarded,
    );
  }

  int get daysUntilEligible {
    final lastDonationDate = latestDonationDate;

    if (lastDonationDate == null) {
      return 0;
    }

    final nextEligibleDate = DateTime(
      lastDonationDate.year,
      lastDonationDate.month + 3,
      lastDonationDate.day,
    );

    final remainingDays = nextEligibleDate.difference(DateTime.now()).inDays;

    return remainingDays < 0 ? 0 : remainingDays;
  }

  String get eligibilityLabel {
    final days = daysUntilEligible;

    if (days == 0) {
      return 'Eligible now';
    }

    final months = days ~/ 30;
    final remainingDays = days % 30;

    if (months == 0) {
      return 'Eligible in $remainingDays days';
    }

    if (remainingDays == 0) {
      return 'Eligible in $months month(s)';
    }

    return 'Eligible in $months month(s), $remainingDays day(s)';
  }

  DateTime? get latestDonationDate {
    if (donationRecords.isNotEmpty) {
      return donationRecords.first.donationDate;
    }

    return donor?.lastDonationDate;
  }

  double get eligibilityProgress {
    final lastDonationDate = latestDonationDate;

    if (lastDonationDate == null) {
      return 1;
    }

    final nextEligibleDate = DateTime(
      lastDonationDate.year,
      lastDonationDate.month + 3,
      lastDonationDate.day,
    );

    final elapsedDays = DateTime.now().difference(lastDonationDate).inDays;
    final totalDays = nextEligibleDate.difference(lastDonationDate).inDays;

    if (totalDays <= 0) {
      return 1;
    }

    return (elapsedDays / totalDays).clamp(0, 1);
  }

  String hospitalName(String hospitalId) {
    return hospitalsById[hospitalId]?.name ?? 'Hospital';
  }

  double distanceToHospital(String hospitalId) {
    final hospital = hospitalsById[hospitalId];
    final currentDonor = donor;

    if (hospital == null || currentDonor == null) {
      return 0;
    }

    return _distanceInKm(
      currentDonor.gpsLatitude,
      currentDonor.gpsLongitude,
      hospital.latitude,
      hospital.longitude,
    );
  }

  double _distanceToAlert(EmergencyAlert alert) {
    final currentDonor = donor;

    if (currentDonor == null) {
      return double.infinity;
    }

    final hospital = hospitalsById[alert.hospitalId];

    if (hospital == null) {
      return double.infinity;
    }

    return _distanceInKm(
      currentDonor.gpsLatitude,
      currentDonor.gpsLongitude,
      hospital.latitude,
      hospital.longitude,
    );
  }

  double _distanceInKm(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const earthRadiusKm = 6371.0;

    final latitudeDistance = _degreesToRadians(endLatitude - startLatitude);
    final longitudeDistance = _degreesToRadians(endLongitude - startLongitude);

    final startLatitudeRadians = _degreesToRadians(startLatitude);
    final endLatitudeRadians = _degreesToRadians(endLatitude);

    final haversine =
        math.sin(latitudeDistance / 2) * math.sin(latitudeDistance / 2) +
        math.cos(startLatitudeRadians) *
            math.cos(endLatitudeRadians) *
            math.sin(longitudeDistance / 2) *
            math.sin(longitudeDistance / 2);

    final centralAngle =
        2 * math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));

    return earthRadiusKm * centralAngle;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}
