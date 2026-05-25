import '../entities/emergency_alert.dart';

import '../repositories/emergency_alert_repository.dart';

class CreateEmergencyAlertUsecase {

  final EmergencyAlertRepository
      repository;

  CreateEmergencyAlertUsecase(
    this.repository,
  );



  Future<void> call(
    EmergencyAlert emergencyAlert,
  ) async {

    await repository
        .createEmergencyAlert(
      emergencyAlert,
    );
  }
}