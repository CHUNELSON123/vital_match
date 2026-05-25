import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/alert_status.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';

class EmergencyAlertModel extends EmergencyAlert {
  const EmergencyAlertModel({
    required super.alertId,
    required super.hospitalId,
    required super.technicianId,
    required super.bloodGroup,
    required super.unitsNeeded,
    required super.radiusKm,
    required super.status,
    required super.createdAt,
  });

  // Convert Model To Map

  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'technicianId': technicianId,
      'bloodGroup': bloodGroup.name,
      'unitsNeeded': unitsNeeded,
      'radiusKm': radiusKm,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Convert Firestore Document To Model

  factory EmergencyAlertModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return EmergencyAlertModel(
      alertId: doc.id,
      hospitalId: data['hospitalId'],
      technicianId: data['technicianId'],
      bloodGroup: BloodType.values.byName(
        data['bloodGroup'],
      ),
      unitsNeeded: data['unitsNeeded'],
      radiusKm: (data['radiusKm'] as num).toDouble(),
      status: AlertStatus.values.byName(
        data['status'],
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}