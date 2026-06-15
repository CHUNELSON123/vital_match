import '../entities/audit_trail.dart';

import '../repositories/audit_trail_repository.dart';

class UpdateAuditTrailUsecase {

  final AuditTrailRepository
      repository;

  UpdateAuditTrailUsecase(
    this.repository,
  );

  Future<void> call(
    AuditTrail auditTrail,
  ) async {

    await repository
        .updateAuditTrail(
      auditTrail,
    );
  }
}