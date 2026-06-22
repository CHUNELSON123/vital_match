import '../entities/blood_unit.dart';
import '../repositories/blood_unit_repository.dart';

class GetAllBloodUnitsUsecase {

  final BloodUnitRepository
      repository;

  GetAllBloodUnitsUsecase(
    this.repository,
  );

  Future<List<BloodUnit>>
      call() async {

    return await repository
        .getAllBloodUnits();
  }
}