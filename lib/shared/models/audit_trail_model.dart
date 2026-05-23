import 'package:cloud_firestore/cloud_firestore.dart';

class AuditTrailModel {
  final String auditId;
  final String userId;
  final String action;
  final String targetEntity;
  final Timestamp timestamp;

  AuditTrailModel({
    required this.auditId,
    required this.userId,
    required this.action,
    required this.targetEntity,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'action': action,
      'targetEntity': targetEntity,
      'timestamp': timestamp,
    };
  }

  factory AuditTrailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AuditTrailModel(
      auditId: doc.id,
      userId: data['userId'] ?? '',
      action: data['action'] ?? '',
      targetEntity: data['targetEntity'] ?? '',
      timestamp: data['timestamp'] ?? '',
    );
  }
}
