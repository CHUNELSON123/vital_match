import '../entities/audit_trail.dart';
import '../repositories/audit_trail_repository.dart';

class GetAuditTrailsByHospitalUsecase {

  final AuditTrailRepository
      repository;

  GetAuditTrailsByHospitalUsecase(
    this.repository,
  );

  Future<List<AuditTrail>> call(
    String hospitalId,
  ) async {

    return await repository
        .getAuditTrailsByHospital(
      hospitalId,
    );
  }
}