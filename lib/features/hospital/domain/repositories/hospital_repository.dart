import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

abstract class HospitalRepository {

  Future<void> createHospital(
    Hospital hospital,
  );

  Future<Hospital> getHospital(
    String hospitalId,
  );

  Future<void> updateHospital(
    Hospital hospital,
  );

  Future<void> deleteHospital(
    String hospitalId,
  );
}