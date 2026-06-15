import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class TechniciansViewModel {

  Future<List<LabTechnician>>
      getTechniciansByHospital(
    String hospitalId,
  ) async {

    return await ServiceLocator
        .getLabTechniciansByHospitalUsecase(
      hospitalId,
    );
  }

  Future<void> createTechnician({
  required String userId,
  required String hospitalId,
  required String employeeId,
  required String department,
}) async {

  final technician = LabTechnician(
    technicianId: '',
    userId: userId,
    hospitalId: hospitalId,
    employeeId: employeeId,
    department: department,
    status: 'Active',
  );

  await ServiceLocator
      .createLabTechnicianUsecase(
    technician,
  );
}
}