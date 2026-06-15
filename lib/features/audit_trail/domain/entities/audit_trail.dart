class AuditTrail {
  final String auditId;
  final String userId;
  final String hospitalId;
  final String action;
  final String targetEntity;
  final DateTime timestamp;

  const AuditTrail({
    required this.auditId,
    required this.userId,
    required this.hospitalId,
    required this.action,
    required this.targetEntity,
    required this.timestamp,
  });
}
