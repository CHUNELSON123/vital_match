import '../entities/hospital_admin.dart';


abstract class
    HospitalAdminRepository {

  Future<void> createHospitalAdmin(
    HospitalAdmin admin,
  );

  Future<HospitalAdmin>
      getHospitalAdmin(
    String adminId,
  );

  Future<List<HospitalAdmin>>
      getAllHospitalAdmins();

  Future<void> updateHospitalAdmin(
    HospitalAdmin admin,
  );

  Future<void> deleteHospitalAdmin(
    String adminId,
  );
}