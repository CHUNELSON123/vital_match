import 'package:vital_match/features/blood_unit/domain/entities/blood_unit.dart';
import 'package:vital_match/features/blood_unit/domain/repositories/blood_unit_repository.dart';

class GetDashboardBloodUnitsUsecase {
  final BloodUnitRepository repository;

  GetDashboardBloodUnitsUsecase(
    this.repository,
  );

  Future<List<BloodUnit>> call() async {
    return await repository
        .getAllBloodUnits();
  }
}