import '../entities/audit_trail.dart';

abstract class AuditTrailRepository {

  Future<void> createAuditTrail(
    AuditTrail auditTrail,
  );

  Future<AuditTrail>
      getAuditTrail(
    String auditId,
  );

  Future<List<AuditTrail>>
      getAllAuditTrails();

  Future<List<AuditTrail>>
      getAuditTrailsByUser(
    String userId,
  );

  Future<void> updateAuditTrail(
    AuditTrail auditTrail,
  );

  Future<void> deleteAuditTrail(
    String auditId,
  );

  Future<List<AuditTrail>>
    getAuditTrailsByHospital(
  String hospitalId,
);
}