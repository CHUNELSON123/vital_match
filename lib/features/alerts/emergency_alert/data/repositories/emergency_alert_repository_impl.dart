import '../../domain/entities/emergency_alert.dart';

import '../../domain/repositories/emergency_alert_repository.dart';

import '../datasources/emergency_alert_remote_datasource.dart';

import '../models/emergency_alert_model.dart';

class EmergencyAlertRepositoryImpl
    implements
        EmergencyAlertRepository {

  final EmergencyAlertRemoteDatasource
      remoteDatasource;

  EmergencyAlertRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createEmergencyAlert(
    EmergencyAlert emergencyAlert,
  ) async {

    final emergencyAlertModel =
        EmergencyAlertModel(
      alertId:
          emergencyAlert.alertId,
      hospitalId:
          emergencyAlert.hospitalId,
      technicianId:
          emergencyAlert.technicianId,
      bloodGroup:
          emergencyAlert.bloodGroup,
      unitsNeeded:
          emergencyAlert.unitsNeeded,
      radiusKm:
          emergencyAlert.radiusKm,
      status:
          emergencyAlert.status,
      createdAt:
          emergencyAlert.createdAt,
    );

    await remoteDatasource
        .createEmergencyAlert(
      emergencyAlertModel,
    );
  }



  @override
  Future<EmergencyAlert>
      getEmergencyAlert(
    String alertId,
  ) async {

    return await remoteDatasource
        .getEmergencyAlert(
      alertId,
    );
  }



  @override
  Future<List<EmergencyAlert>>
      getAllEmergencyAlerts() async {

    return await remoteDatasource
        .getAllEmergencyAlerts();
  }



  @override
  Future<void> updateEmergencyAlert(
    EmergencyAlert emergencyAlert,
  ) async {

    final emergencyAlertModel =
        EmergencyAlertModel(
      alertId:
          emergencyAlert.alertId,
      hospitalId:
          emergencyAlert.hospitalId,
      technicianId:
          emergencyAlert.technicianId,
      bloodGroup:
          emergencyAlert.bloodGroup,
      unitsNeeded:
          emergencyAlert.unitsNeeded,
      radiusKm:
          emergencyAlert.radiusKm,
      status:
          emergencyAlert.status,
      createdAt:
          emergencyAlert.createdAt,
    );

    await remoteDatasource
        .updateEmergencyAlert(
      emergencyAlertModel,
    );
  }



  @override
  Future<void> deleteEmergencyAlert(
    String alertId,
  ) async {

    await remoteDatasource
        .deleteEmergencyAlert(
      alertId,
    );
  }

  @override
Future<List<EmergencyAlert>>
    getEmergencyAlertsByHospital(
  String hospitalId,
) async {

  return await remoteDatasource
      .getEmergencyAlertsByHospital(
    hospitalId,
  );
}
}