import 'package:vital_match/features/alerts/emergency_alert/data/models/emergency_alert_model.dart';

abstract class EmergencyAlertRemoteDatasource {
  Future<void> createEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  );

  Future<EmergencyAlertModel> getEmergencyAlert(
    String alertId,
  );

  Future<List<EmergencyAlertModel>> getAllEmergencyAlerts();

  Future<void> updateEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  );

  Future<void> deleteEmergencyAlert(
    String alertId,
  );
}