import '../repositories/emergency_alert_repository.dart';

class DeleteEmergencyAlertUsecase {

  final EmergencyAlertRepository
      repository;

  DeleteEmergencyAlertUsecase(
    this.repository,
  );



  Future<void> call(
    String alertId,
  ) async {

    await repository
        .deleteEmergencyAlert(
      alertId,
    );
  }
}