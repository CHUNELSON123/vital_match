import '../models/hospital_model.dart';

abstract class HospitalRemoteDatasource {

  Future<void> createHospital(
    HospitalModel hospital,
  );

  Future<HospitalModel> getHospital(
    String hospitalId,
  );

  Future<void> updateHospital(
    HospitalModel hospital,
  );

  Future<void> deleteHospital(
    String hospitalId,
  );
}