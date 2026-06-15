import '../models/audit_trail_model.dart';

abstract class AuditTrailRemoteDatasource {

  Future<void> createAuditTrail(
    AuditTrailModel auditTrail,
  );

  Future<AuditTrailModel>
      getAuditTrail(
    String auditId,
  );

  Future<List<AuditTrailModel>>
      getAllAuditTrails();

  Future<List<AuditTrailModel>>
      getAuditTrailsByUser(
    String userId,
  );

  Future<void> updateAuditTrail(
    AuditTrailModel auditTrail,
  );

  Future<void> deleteAuditTrail(
    String auditId,
  );

  Future<List<AuditTrailModel>>
    getAuditTrailsByHospital(
  String hospitalId,
);
}