import '../entities/blood_unit.dart';

import '../repositories/blood_unit_repository.dart';

class GetBloodUnitUsecase {

  final BloodUnitRepository repository;

  GetBloodUnitUsecase(
    this.repository,
  );

  Future<BloodUnit> call(
    String bloodUnitId,
  ) async {

    return await repository.getBloodUnit(
      bloodUnitId,
    );
  }
}