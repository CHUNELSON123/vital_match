import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/audit_trail.dart';

class AuditTrailModel
    extends AuditTrail {

  const AuditTrailModel({
    required super.auditId,
    required super.userId,
    required super.hospitalId,
    required super.action,
    required super.targetEntity,
    required super.timestamp,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hospitalId': hospitalId,
      'action': action,
      'targetEntity':
          targetEntity,
      'timestamp':
          timestamp.toIso8601String(),
    };
  }


  factory AuditTrailModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return AuditTrailModel(
      auditId: doc.id,
      userId: data['userId'] ?? '',
      hospitalId: data['hospitalId'] ?? '',
      action: data['action'] ?? '',
      targetEntity:
          data['targetEntity'] ?? '',
      timestamp: DateTime.parse(
        data['timestamp'],
      ),
    );
  }
}