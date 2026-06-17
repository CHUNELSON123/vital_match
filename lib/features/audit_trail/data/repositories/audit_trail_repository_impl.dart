import '../../domain/entities/audit_trail.dart';

import '../../domain/repositories/audit_trail_repository.dart';

import '../datasources/audit_trail_remote_datasource.dart';

import '../models/audit_trail_model.dart';

class AuditTrailRepositoryImpl
    implements AuditTrailRepository {

  final AuditTrailRemoteDatasource
      remoteDatasource;

  AuditTrailRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createAuditTrail(
    AuditTrail auditTrail,
  ) async {

    final auditTrailModel =
        AuditTrailModel(
      auditId: auditTrail.auditId,
      userId: auditTrail.userId,
      hospitalId: auditTrail.hospitalId,
      action: auditTrail.action,
      targetEntity:
          auditTrail.targetEntity,
      timestamp:
          auditTrail.timestamp,
      userName: auditTrail.userName,
      targetName: auditTrail.targetName,
    );

    await remoteDatasource
        .createAuditTrail(
      auditTrailModel,
    );
  }



  @override
  Future<AuditTrail>
      getAuditTrail(
    String auditId,
  ) async {

    return await remoteDatasource
        .getAuditTrail(
      auditId,
    );
  }



  @override
  Future<List<AuditTrail>>
      getAllAuditTrails() async {

    return await remoteDatasource
        .getAllAuditTrails();
  }



  @override
  Future<List<AuditTrail>>
      getAuditTrailsByUser(
    String userId,
  ) async {

    return await remoteDatasource
        .getAuditTrailsByUser(
      userId,
    );
  }



  @override
  Future<void> updateAuditTrail(
    AuditTrail auditTrail,
  ) async {

    final auditTrailModel =
        AuditTrailModel(
      auditId: auditTrail.auditId,
      userId: auditTrail.userId,
      hospitalId: auditTrail.hospitalId,
      action: auditTrail.action,
      targetEntity:
          auditTrail.targetEntity,
      timestamp:
          auditTrail.timestamp,
      userName: auditTrail.userName,
      targetName: auditTrail.targetName,
    );

    await remoteDatasource
        .updateAuditTrail(
      auditTrailModel,
    );
  }



  @override
  Future<void> deleteAuditTrail(
    String auditId,
  ) async {

    await remoteDatasource
        .deleteAuditTrail(
      auditId,
    );
  }

  @override
Future<List<AuditTrail>>
    getAuditTrailsByHospital(
  String hospitalId,
) async {

  return await remoteDatasource
      .getAuditTrailsByHospital(
    hospitalId,
  );
}
}