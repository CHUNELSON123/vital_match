import '../entities/lab_technician.dart';

import '../repositories/lab_technician_repository.dart';


class CreateLabTechnicianUsecase {

  final LabTechnicianRepository
      repository;

  CreateLabTechnicianUsecase(
    this.repository,
  );

  Future<void> call(
    LabTechnician technician,
  ) async {

    await repository
        .createLabTechnician(
      technician,
    );
  }
}