import '../repositories/hospital_admin_repository.dart';


class DeleteHospitalAdminUsecase {

  final HospitalAdminRepository
      repository;

  DeleteHospitalAdminUsecase(
    this.repository,
  );

  Future<void> call(
    String adminId,
  ) async {

    await repository
        .deleteHospitalAdmin(
      adminId,
    );
  }
}