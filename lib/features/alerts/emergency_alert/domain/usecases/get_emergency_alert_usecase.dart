import '../entities/emergency_alert.dart';

import '../repositories/emergency_alert_repository.dart';

class GetEmergencyAlertUsecase {

  final EmergencyAlertRepository
      repository;

  GetEmergencyAlertUsecase(
    this.repository,
  );



  Future<EmergencyAlert> call(
    String alertId,
  ) async {

    return await repository
        .getEmergencyAlert(
      alertId,
    );
  }
}