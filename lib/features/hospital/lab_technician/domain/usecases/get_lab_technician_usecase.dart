import '../entities/lab_technician.dart';

import '../repositories/lab_technician_repository.dart';


class GetLabTechnicianUsecase {

  final LabTechnicianRepository
      repository;

  GetLabTechnicianUsecase(
    this.repository,
  );

  Future<LabTechnician> call(
    String technicianId,
  ) async {

    return await repository
        .getLabTechnician(
      technicianId,
    );
  }
}