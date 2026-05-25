import '../entities/blood_unit.dart';

import '../repositories/blood_unit_repository.dart';

class UpdateBloodUnitUsecase {

  final BloodUnitRepository repository;

  UpdateBloodUnitUsecase(
    this.repository,
  );

  Future<void> call(
    BloodUnit bloodUnit,
  ) async {

    await repository.updateBloodUnit(
      bloodUnit,
    );
  }
}