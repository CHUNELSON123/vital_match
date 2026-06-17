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

    required super.userName,
    required super.targetName,
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
      'userName': userName,
      'targetName': targetName,
    };
  }


 factory AuditTrailModel.fromMap(
  Map<String, dynamic> data,
) {
  return AuditTrailModel(
    auditId:
        data['auditId'] ?? '',
    userId:
        data['userId'] ?? '',
    hospitalId:
        data['hospitalId'] ?? '',
    action:
        data['action'] ?? '',
    targetEntity:
        data['targetEntity'] ?? '',
    timestamp: DateTime.parse(
      data['timestamp'],
    ),

    userName:
        data['userName'] ?? '',

    targetName:
        data['targetName'] ?? '',
  );
}
}