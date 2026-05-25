import '../repositories/blood_unit_repository.dart';

class DeleteBloodUnitUsecase {

  final BloodUnitRepository repository;

  DeleteBloodUnitUsecase(
    this.repository,
  );

  Future<void> call(
    String bloodUnitId,
  ) async {

    await repository.deleteBloodUnit(
      bloodUnitId,
    );
  }
}