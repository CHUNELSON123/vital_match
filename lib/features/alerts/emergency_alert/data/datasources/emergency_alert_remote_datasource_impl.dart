import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/emergency_alert_model.dart';

import 'emergency_alert_remote_datasource.dart';

class EmergencyAlertRemoteDatasourceImpl
    implements
        EmergencyAlertRemoteDatasource {

  final FirebaseFirestore firestore;

  EmergencyAlertRemoteDatasourceImpl(
    this.firestore,
  );

  final String emergencyAlertCollection =
      'emergency_alerts';



  @override
  Future<void> createEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  ) async {

    await firestore
        .collection(
          emergencyAlertCollection,
        )
        .doc(
          emergencyAlert.alertId,
        )
        .set(
          emergencyAlert.toMap(),
        );
  }



  @override
  Future<EmergencyAlertModel>
      getEmergencyAlert(
    String alertId,
  ) async {

    final doc =
        await firestore
            .collection(
              emergencyAlertCollection,
            )
            .doc(
              alertId,
            )
            .get();

    return EmergencyAlertModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<EmergencyAlertModel>>
      getAllEmergencyAlerts() async {

    final snapshot =
        await firestore
            .collection(
              emergencyAlertCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              EmergencyAlertModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateEmergencyAlert(
    EmergencyAlertModel emergencyAlert,
  ) async {

    await firestore
        .collection(
          emergencyAlertCollection,
        )
        .doc(
          emergencyAlert.alertId,
        )
        .update(
          emergencyAlert.toMap(),
        );
  }



  @override
  Future<void> deleteEmergencyAlert(
    String alertId,
  ) async {

    await firestore
        .collection(
          emergencyAlertCollection,
        )
        .doc(
          alertId,
        )
        .delete();
  }
}