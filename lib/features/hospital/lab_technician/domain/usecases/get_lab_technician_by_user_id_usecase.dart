import '../entities/lab_technician.dart';
import '../repositories/lab_technician_repository.dart';

class GetLabTechnicianByUserIdUsecase {
  final LabTechnicianRepository repository;

  GetLabTechnicianByUserIdUsecase(
    this.repository,
  );

  Future<LabTechnician?> call(
    String userId,
  ) async {
    return await repository
        .getLabTechnicianByUserId(
      userId,
    );
  }
}