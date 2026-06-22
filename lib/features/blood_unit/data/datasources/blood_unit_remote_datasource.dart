import '../models/blood_unit_model.dart';

abstract class BloodUnitRemoteDatasource {

  Future<void> createBloodUnit(
    BloodUnitModel bloodUnit,
  );

  Future<BloodUnitModel> getBloodUnit(
    String bloodUnitId,
  );

  Future<void> updateBloodUnit(
    BloodUnitModel bloodUnit,
  );

  Future<void> deleteBloodUnit(
    String bloodUnitId,
  );

  Future<List<BloodUnitModel>>
    getAllBloodUnits();

Future<List<BloodUnitModel>>
    getBloodUnitsByHospital(
  String hospitalId,
);
}