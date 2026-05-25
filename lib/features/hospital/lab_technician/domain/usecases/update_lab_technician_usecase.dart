import '../entities/lab_technician.dart';

import '../repositories/lab_technician_repository.dart';


class UpdateLabTechnicianUsecase {

  final LabTechnicianRepository
      repository;

  UpdateLabTechnicianUsecase(
    this.repository,
  );

  Future<void> call(
    LabTechnician technician,
  ) async {

    await repository
        .updateLabTechnician(
      technician,
    );
  }
}