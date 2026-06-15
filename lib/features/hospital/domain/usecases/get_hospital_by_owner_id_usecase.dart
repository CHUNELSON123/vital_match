import '../entities/hospital.dart';
import '../repositories/hospital_repository.dart';

class GetHospitalByOwnerIdUsecase {

  final HospitalRepository repository;

  GetHospitalByOwnerIdUsecase(
    this.repository,
  );

  Future<Hospital?> call(
    String ownerId,
  ) async {

    return await repository
        .getHospitalByOwnerId(
      ownerId,
    );
  }
}