import '../entities/emergency_alert.dart';

abstract class EmergencyAlertRepository {

  Future<void> createEmergencyAlert(
    EmergencyAlert emergencyAlert,
  );



  Future<EmergencyAlert>
      getEmergencyAlert(
    String alertId,
  );



  Future<List<EmergencyAlert>>
      getAllEmergencyAlerts();



  Future<void> updateEmergencyAlert(
    EmergencyAlert emergencyAlert,
  );



  Future<void> deleteEmergencyAlert(
    String alertId,
  );

  Future<List<EmergencyAlert>>
    getEmergencyAlertsByHospital(
  String hospitalId,
);
}