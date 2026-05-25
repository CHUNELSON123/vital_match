import '../models/hospital_admin_model.dart';


abstract class
    HospitalAdminRemoteDatasource {

  Future<void> createHospitalAdmin(
    HospitalAdminModel admin,
  );

  Future<HospitalAdminModel>
      getHospitalAdmin(
    String adminId,
  );

  Future<List<HospitalAdminModel>>
      getAllHospitalAdmins();

  Future<void> updateHospitalAdmin(
    HospitalAdminModel admin,
  );

  Future<void> deleteHospitalAdmin(
    String adminId,
  );
}