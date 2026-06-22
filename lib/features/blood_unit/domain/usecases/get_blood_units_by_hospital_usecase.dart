import '../entities/blood_unit.dart';
import '../repositories/blood_unit_repository.dart';

class GetBloodUnitsByHospitalUsecase {

  final BloodUnitRepository
      repository;

  GetBloodUnitsByHospitalUsecase(
    this.repository,
  );

  Future<List<BloodUnit>>
      call(
    String hospitalId,
  ) async {

    return await repository
        .getBloodUnitsByHospital(
      hospitalId,
    );
  }
}