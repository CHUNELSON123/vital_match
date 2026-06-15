import '../entities/audit_trail.dart';

import '../repositories/audit_trail_repository.dart';

class CreateAuditTrailUsecase {

  final AuditTrailRepository
      repository;

  CreateAuditTrailUsecase(
    this.repository,
  );

  Future<void> call(
    AuditTrail auditTrail,
  ) async {

    await repository
        .createAuditTrail(
      auditTrail,
    );
  }
}