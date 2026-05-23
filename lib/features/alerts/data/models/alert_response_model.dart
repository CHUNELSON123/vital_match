import 'package:cloud_firestore/cloud_firestore.dart';

class AlertResponseModel {
  final String responseId;
  final String alertId;
  final String donorId;
  final String status;
  final Timestamp respondedAt;

  AlertResponseModel({
    required this.responseId,
    required this.alertId,
    required this.donorId,
    required this.status,
    required this.respondedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'alertId': alertId,
      'donorId': donorId,
      'status': status,
      'respondedAt': respondedAt,
    };
  }

  factory AlertResponseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AlertResponseModel (
      responseId: doc.id,
      alertId: data['alertId'] ?? '',
      donorId: data['donorId'] ?? '',
      status: data['status'] ?? '',
      respondedAt: data['respondedAt'] ?? '',
    );
  }
}
