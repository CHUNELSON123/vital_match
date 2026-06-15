import '../entities/emergency_alert.dart';
import '../repositories/emergency_alert_repository.dart';

class UpdateEmergencyAlertUsecase {

  final EmergencyAlertRepository
      repository;

  UpdateEmergencyAlertUsecase(
    this.repository,
  );



  Future<void> call(
    EmergencyAlert emergencyAlert,
  ) async {

    await repository
        .updateEmergencyAlert(
      emergencyAlert,
    );
  }
}