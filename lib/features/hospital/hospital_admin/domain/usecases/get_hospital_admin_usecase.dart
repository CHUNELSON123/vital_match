import '../entities/hospital_admin.dart';

import '../repositories/hospital_admin_repository.dart';


class GetHospitalAdminUsecase {

  final HospitalAdminRepository
      repository;

  GetHospitalAdminUsecase(
    this.repository,
  );

  Future<HospitalAdmin> call(
    String adminId,
  ) async {

    return await repository
        .getHospitalAdmin(
      adminId,
    );
  }
}