import '../entities/hospital_admin.dart';

import '../repositories/hospital_admin_repository.dart';


class CreateHospitalAdminUsecase {

  final HospitalAdminRepository
      repository;

  CreateHospitalAdminUsecase(
    this.repository,
  );

  Future<void> call(
    HospitalAdmin admin,
  ) async {

    await repository
        .createHospitalAdmin(
      admin,
    );
  }
}