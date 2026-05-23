import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyAlertModel {
  final String alertId;
  final String hospitalId;
  final String technicianId;
  final String bloodTypeRequired;
  final String status;
  final int unitsNeeded;
  final int radiusKm;
  final Timestamp createdAt;

  EmergencyAlertModel({
    required this.alertId,
    required this.hospitalId,
    required this.technicianId,
    required this.bloodTypeRequired,
    required this.status,
    required this.unitsNeeded,
    required this.radiusKm,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'technicianId': technicianId,
      'bloodTypeRequired': bloodTypeRequired,
      'status': status,
      'unitsNeeded': unitsNeeded,
      'radiusKm': radiusKm,
      'createdAt': createdAt,
    };
  }

  factory EmergencyAlertModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return EmergencyAlertModel(
      alertId: doc.id,
      hospitalId: data['hospitalId'] ?? '',
      technicianId: data['technicianId'] ?? '',
      bloodTypeRequired: data['bloodTypeRequired'] ?? '',
      status: data['status'] ?? '',
      unitsNeeded: data['unitsNeeded'] ?? 0,
      radiusKm: data['radiusKm'] ?? 0,
      createdAt: data['createdAt'] ?? '',
    );
  }
}
