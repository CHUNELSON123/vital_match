import '../../domain/entities/hospital_admin.dart';

import '../../domain/repositories/hospital_admin_repository.dart';

import '../datasources/hospital_admin_remote_datasource.dart';

import '../models/hospital_admin_model.dart';


class HospitalAdminRepositoryImpl
    implements
        HospitalAdminRepository {

  final HospitalAdminRemoteDatasource
      remoteDatasource;

  HospitalAdminRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createHospitalAdmin(
    HospitalAdmin admin,
  ) async {

    final hospitalAdminModel =
        HospitalAdminModel(
      adminId: admin.adminId,
      userId: admin.userId,
      hospitalId:
          admin.hospitalId,
      adminLevel:
          admin.adminLevel,
    );

    await remoteDatasource
        .createHospitalAdmin(
      hospitalAdminModel,
    );
  }



  @override
  Future<HospitalAdmin>
      getHospitalAdmin(
    String adminId,
  ) async {

    return await remoteDatasource
        .getHospitalAdmin(
      adminId,
    );
  }



  @override
  Future<List<HospitalAdmin>>
      getAllHospitalAdmins() async {

    return await remoteDatasource
        .getAllHospitalAdmins();
  }



  @override
  Future<void> updateHospitalAdmin(
    HospitalAdmin admin,
  ) async {

    final hospitalAdminModel =
        HospitalAdminModel(
      adminId: admin.adminId,
      userId: admin.userId,
      hospitalId:
          admin.hospitalId,
      adminLevel:
          admin.adminLevel,
    );

    await remoteDatasource
        .updateHospitalAdmin(
      hospitalAdminModel,
    );
  }



  @override
  Future<void> deleteHospitalAdmin(
    String adminId,
  ) async {

    await remoteDatasource
        .deleteHospitalAdmin(
      adminId,
    );
  }
}