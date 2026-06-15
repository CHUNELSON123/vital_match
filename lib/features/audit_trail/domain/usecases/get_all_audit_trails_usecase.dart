import '../entities/audit_trail.dart';

import '../repositories/audit_trail_repository.dart';

class GetAllAuditTrailsUsecase {

  final AuditTrailRepository
      repository;

  GetAllAuditTrailsUsecase(
    this.repository,
  );

  Future<List<AuditTrail>>
      call() async {

    return await repository
        .getAllAuditTrails();
  }
}