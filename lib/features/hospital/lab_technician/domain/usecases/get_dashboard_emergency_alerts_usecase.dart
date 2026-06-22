import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/repositories/emergency_alert_repository.dart';

class GetDashboardEmergencyAlertsUsecase {
  final EmergencyAlertRepository
      repository;

  GetDashboardEmergencyAlertsUsecase(
    this.repository,
  );

  Future<List<EmergencyAlert>>
      call() async {

    return await repository
        .getAllEmergencyAlerts();
  }
}