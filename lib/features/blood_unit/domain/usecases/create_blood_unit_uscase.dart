import '../entities/blood_unit.dart';

import '../repositories/blood_unit_repository.dart';

class CreateBloodUnitUsecase {

  final BloodUnitRepository repository;

  CreateBloodUnitUsecase(
    this.repository,
  );

  Future<void> call(
    BloodUnit bloodUnit,
  ) async {

    await repository.createBloodUnit(
      bloodUnit,
    );
  }
}