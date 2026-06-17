import '../../data/datasources/audit_trail_remote_datasource_impl.dart';
import '../../data/repositories/audit_trail_repository_impl.dart';

import '../../domain/entities/audit_trail.dart';

import '../../domain/usecases/get_audit_trails_by_hospital_usecase.dart';

class AuditTrailViewModel {

  late final GetAuditTrailsByHospitalUsecase
      getAuditTrailsByHospitalUsecase;

  AuditTrailViewModel() {

    final repository =
        AuditTrailRepositoryImpl(
      AuditTrailRemoteDatasourceImpl(),
    );

    getAuditTrailsByHospitalUsecase =
        GetAuditTrailsByHospitalUsecase(
      repository,
    );
  }

  Future<List<AuditTrail>>
      getAuditTrailsByHospital(
    String hospitalId,
  ) async {

    return await
        getAuditTrailsByHospitalUsecase(
      hospitalId,
    );
  }
}