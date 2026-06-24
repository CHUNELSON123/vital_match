import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/core/enums/alert_status.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/usecases/create_emergency_alert_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class EmergencyAlertViewModel extends ChangeNotifier {
  final CreateEmergencyAlertUsecase createEmergencyAlertUsecase;

  EmergencyAlertViewModel({
    required this.createEmergencyAlertUsecase,
  });

  bool isLoading = false;
  bool isSending = false;
  String? errorMessage;
  String? successMessage;

  BloodType selectedBloodType = BloodType.oNegative;
  String priority = 'Critical';
  LabTechnician? currentTechnician;

  final unitsNeededController = TextEditingController(
    text: '12',
  );

  final radiusController = TextEditingController(
    text: '25',
  );

  final descriptionController = TextEditingController(
    text: 'Critical shortage in Emergency Unit.',
  );

  Future<void> loadCurrentTechnician() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uid =
          FirebaseAuth.instance.currentUser!.uid;

      currentTechnician =
          await ServiceLocator
              .getLabTechnicianByUserIdUsecase(
        uid,
      );

      if (currentTechnician == null) {
        errorMessage =
            'Lab technician profile not found.';
      }
    } catch (e) {
      errorMessage =
          'Failed to load lab technician profile.';
      debugPrint('LOAD CURRENT TECHNICIAN FAILED: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeBloodType(
    BloodType bloodType,
  ) {
    selectedBloodType = bloodType;
    notifyListeners();
  }

  void changePriority(
    String value,
  ) {
    priority = value;
    notifyListeners();
  }

  void refreshPreview() {
    notifyListeners();
  }

  Future<bool> sendEmergencyAlert() async {
    errorMessage = null;
    successMessage = null;

    final technician = currentTechnician;

    if (technician == null) {
      errorMessage =
          'Lab technician profile not loaded.';
      notifyListeners();
      return false;
    }

    final unitsNeeded =
        int.tryParse(
      unitsNeededController.text.trim(),
    );

    final radiusKm =
        double.tryParse(
      radiusController.text.trim(),
    );

    if (unitsNeeded == null ||
        unitsNeeded <= 0) {
      errorMessage =
          'Units needed must be greater than 0.';
      notifyListeners();
      return false;
    }

    if (radiusKm == null || radiusKm <= 0) {
      errorMessage =
          'Radius must be greater than 0.';
      notifyListeners();
      return false;
    }

    isSending = true;
    notifyListeners();

    final emergencyAlert = EmergencyAlert(
      alertId: '',
      hospitalId: technician.hospitalId,
      technicianId: technician.technicianId,
      bloodGroup: selectedBloodType,
      unitsNeeded: unitsNeeded,
      radiusKm: radiusKm,
      status: AlertStatus.active,
      createdAt: DateTime.now(),
    );

    try {
      await createEmergencyAlertUsecase(
        emergencyAlert,
      );

      successMessage =
          'Emergency alert sent successfully.';
      return true;
    } catch (e) {
      errorMessage =
          'Failed to send emergency alert.';
      debugPrint('SEND EMERGENCY ALERT FAILED: $e');
      return false;
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    unitsNeededController.dispose();
    radiusController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
