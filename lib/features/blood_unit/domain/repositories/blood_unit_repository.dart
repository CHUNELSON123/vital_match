import '../entities/blood_unit.dart';

abstract class BloodUnitRepository {

  Future<void> createBloodUnit(
    BloodUnit bloodUnit,
  );

  Future<BloodUnit> getBloodUnit(
    String bloodUnitId,
  );

  Future<void> updateBloodUnit(
    BloodUnit bloodUnit,
  );

  Future<void> deleteBloodUnit(
    String bloodUnitId,
  );
}