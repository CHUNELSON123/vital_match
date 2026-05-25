import '../entities/lab_technician.dart';

import '../repositories/lab_technician_repository.dart';


class GetAllLabTechniciansUsecase {

  final LabTechnicianRepository
      repository;

  GetAllLabTechniciansUsecase(
    this.repository,
  );

  Future<List<LabTechnician>>
      call() async {

    return await repository
        .getAllLabTechnicians();
  }
}