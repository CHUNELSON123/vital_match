import '../entities/lab_technician.dart';
import '../repositories/lab_technician_repository.dart';

class GetLabTechniciansByHospitalUsecase {

  final LabTechnicianRepository
      repository;

  GetLabTechniciansByHospitalUsecase(
    this.repository,
  );

  Future<List<LabTechnician>> call(
    String hospitalId,
  ) async {

    return await repository
        .getLabTechniciansByHospital(
      hospitalId,
    );
  }
}