import '../entities/hospital_admin.dart';

import '../repositories/hospital_admin_repository.dart';


class GetAllHospitalAdminsUsecase {

  final HospitalAdminRepository
      repository;

  GetAllHospitalAdminsUsecase(
    this.repository,
  );

  Future<List<HospitalAdmin>>
      call() async {

    return await repository
        .getAllHospitalAdmins();
  }
}