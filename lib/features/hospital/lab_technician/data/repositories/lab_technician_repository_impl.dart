import '../../domain/entities/lab_technician.dart';

import '../../domain/repositories/lab_technician_repository.dart';

import '../datasources/lab_technician_remote_datasource.dart';

import '../models/lab_technician_model.dart';


class LabTechnicianRepositoryImpl
    implements
        LabTechnicianRepository {

  final LabTechnicianRemoteDatasource
      remoteDatasource;

  LabTechnicianRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createLabTechnician(
    LabTechnician technician,
  ) async {

    final technicianModel =
        LabTechnicianModel(
      technicianId:
          technician.technicianId,

      userId:
          technician.userId,

      hospitalId:
          technician.hospitalId,

      employeeId:
          technician.employeeId,

      department:
          technician.department,
    );

    await remoteDatasource
        .createLabTechnician(
      technicianModel,
    );
  }



  @override
  Future<LabTechnician>
      getLabTechnician(
    String technicianId,
  ) async {

    return await remoteDatasource
        .getLabTechnician(
      technicianId,
    );
  }



  @override
  Future<List<LabTechnician>>
      getAllLabTechnicians() async {

    return await remoteDatasource
        .getAllLabTechnicians();
  }



  @override
  Future<void> updateLabTechnician(
    LabTechnician technician,
  ) async {

    final technicianModel =
        LabTechnicianModel(
      technicianId:
          technician.technicianId,

      userId:
          technician.userId,

      hospitalId:
          technician.hospitalId,

      employeeId:
          technician.employeeId,

      department:
          technician.department,
    );

    await remoteDatasource
        .updateLabTechnician(
      technicianModel,
    );
  }



  @override
  Future<void> deleteLabTechnician(
    String technicianId,
  ) async {

    await remoteDatasource
        .deleteLabTechnician(
      technicianId,
    );
  }
}