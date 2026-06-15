import '../entities/audit_trail.dart';

import '../repositories/audit_trail_repository.dart';

class GetAuditTrailsByUserUsecase {

  final AuditTrailRepository
      repository;

  GetAuditTrailsByUserUsecase(
    this.repository,
  );

  Future<List<AuditTrail>> call(
    String userId,
  ) async {

    return await repository
        .getAuditTrailsByUser(
      userId,
    );
  }
}