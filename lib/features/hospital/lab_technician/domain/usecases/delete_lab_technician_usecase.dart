import '../repositories/lab_technician_repository.dart';


class DeleteLabTechnicianUsecase {

  final LabTechnicianRepository
      repository;

  DeleteLabTechnicianUsecase(
    this.repository,
  );

  Future<void> call(
    String technicianId,
  ) async {

    await repository
        .deleteLabTechnician(
      technicianId,
    );
  }
}