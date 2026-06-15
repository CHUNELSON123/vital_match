import '../entities/audit_trail.dart';

import '../repositories/audit_trail_repository.dart';

class GetAuditTrailUsecase {

  final AuditTrailRepository
      repository;

  GetAuditTrailUsecase(
    this.repository,
  );

  Future<AuditTrail> call(
    String auditId,
  ) async {

    return await repository
        .getAuditTrail(
      auditId,
    );
  }
}