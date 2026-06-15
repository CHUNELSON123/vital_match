import '../repositories/audit_trail_repository.dart';

class DeleteAuditTrailUsecase {

  final AuditTrailRepository
      repository;

  DeleteAuditTrailUsecase(
    this.repository,
  );

  Future<void> call(
    String auditId,
  ) async {

    await repository
        .deleteAuditTrail(
      auditId,
    );
  }
}