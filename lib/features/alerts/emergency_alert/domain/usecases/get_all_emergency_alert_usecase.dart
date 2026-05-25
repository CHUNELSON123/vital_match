import '../entities/emergency_alert.dart';

import '../repositories/emergency_alert_repository.dart';

class GetAllEmergencyAlertsUsecase {

  final EmergencyAlertRepository
      repository;

  GetAllEmergencyAlertsUsecase(
    this.repository,
  );



  Future<List<EmergencyAlert>>
      call() async {

    return await repository
        .getAllEmergencyAlerts();
  }
}