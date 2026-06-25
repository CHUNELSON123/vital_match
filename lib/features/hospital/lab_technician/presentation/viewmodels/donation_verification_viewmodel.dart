import 'package:flutter/material.dart';
import 'package:vital_match/core/enums/donation_record_status.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donation_record/domain/usecases/get_pending_donation_records_usecase.dart';
import 'package:vital_match/features/donation_record/domain/usecases/update_donation_record_usecase.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/donors/domain/usecases/get_donor_usecase.dart';
import 'package:vital_match/features/users/domain/usecase/get_user_by_id_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/notification_type.dart';

class DonationVerificationViewModel extends ChangeNotifier {
  final GetPendingDonationRecordsUsecase getPendingDonationRecordsUsecase;
  final UpdateDonationRecordUsecase updateDonationRecordUsecase;
  final GetDonorUsecase getDonorUsecase;
  final GetUserByIdUsecase getUserUsecase;

  DonationVerificationViewModel({
    required this.getPendingDonationRecordsUsecase,
    required this.updateDonationRecordUsecase,
    required this.getDonorUsecase,
    required this.getUserUsecase,
  });

  bool isLoading = false;
  bool isUpdating = false;
  List<DonationRecord> pendingDonations = [];

  DonationRecord? selectedDonation;
  Donor? donor;
  String? donorName;

  Future<void> loadPendingDonations() async {
    isLoading = true;
    notifyListeners();

    try {
      pendingDonations = await getPendingDonationRecordsUsecase();

      if (pendingDonations.isNotEmpty) {
        selectedDonation = pendingDonations.first;
        await loadDonor();
      } else {
        selectedDonation = null;
        donor = null;
        donorName = null;
      }
    } catch (e) {
      debugPrint('Error loading pending donations: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDonor() async {
    if (selectedDonation == null) return;

    try {
      donor = await getDonorUsecase(selectedDonation!.donorId);

      if (donor != null) {
        final user = await getUserUsecase(donor!.userId);
        donorName = user?.fullName ?? 'Unknown Donor';
      } else {
        donorName = 'Unknown Donor';
      }
    } catch (e) {
      debugPrint('Error loading donor/user: $e');
      donorName = 'Unknown Donor';
    }

    notifyListeners();
  }

  Future<void> selectDonation(DonationRecord donation) async {
    selectedDonation = donation;
    donor = null;
    donorName = null;
    notifyListeners();
    await loadDonor();
  }

  Future<void> updateDonationStatus(
    DonationRecord donation,
    DonationRecordStatus status,
  ) async {
    isUpdating = true;
    notifyListeners();

    final updatedDonation = DonationRecord(
      recordId: donation.recordId,
      donorId: donation.donorId,
      hospitalId: donation.hospitalId,
      technicianId: donation.technicianId,
      donationDate: donation.donationDate,
      bloodUnitsCollected: donation.bloodUnitsCollected,
      pointsAwarded: donation.pointsAwarded,
      bloodGroup: donation.bloodGroup,
      donorWeight: donation.donorWeight,
      status: status,
    );

    try {
      await updateDonationRecordUsecase(updatedDonation);
      await _notifyDonor(updatedDonation, status);

      pendingDonations = pendingDonations
          .where(
            (item) => item.recordId != donation.recordId,
          )
          .toList();

      selectedDonation =
          pendingDonations.isNotEmpty ? pendingDonations.first : null;
      donor = null;
      donorName = null;

      if (selectedDonation != null) {
        await loadDonor();
      }
    } catch (e) {
      debugPrint('Error updating donation status: $e');
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }

  Future<void> _notifyDonor(
    DonationRecord donation,
    DonationRecordStatus status,
  ) async {
    final title = status == DonationRecordStatus.verified
        ? 'Donation verified'
        : 'Donation rejected';
    final message = status == DonationRecordStatus.verified
        ? 'Your donation has been verified. Thank you for saving lives.'
        : 'Your donation could not be verified. Please contact the hospital for details.';

    final notificationRef = FirebaseFirestore.instance
        .collection('notifications')
        .doc();

    await notificationRef.set({
      'userId': donation.donorId,
      'alertId': donation.recordId,
      'type': NotificationType.general.name,
      'title': title,
      'message': message,
      'isRead': false,
      'sentAt': Timestamp.now(),
      'channel': 'whatsappLink',
      'deepLink': 'vitalmatch://donor/donations/${donation.recordId}',
      'actions': ['open'],
    });
  }
}
