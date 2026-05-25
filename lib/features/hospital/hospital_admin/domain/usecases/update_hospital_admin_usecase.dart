import '../entities/hospital_admin.dart';

import '../repositories/hospital_admin_repository.dart';


class UpdateHospitalAdminUsecase {

  final HospitalAdminRepository
      repository;

  UpdateHospitalAdminUsecase(
    this.repository,
  );

  Future<void> call(
    HospitalAdmin admin,
  ) async {

    await repository
        .updateHospitalAdmin(
      admin,
    );
  }
}