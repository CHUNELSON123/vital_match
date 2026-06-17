import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class CreateTechnicianViewModel {

  Future<void> createTechnician({
  required String fullName,
  required String email,
  required String phoneNumber,
  required String hospitalId,
  required String employeeId,
  required String department,
}) async {

   

  final technician =
    LabTechnician(
  technicianId: '',
  userId: '',
  hospitalId: hospitalId,
  employeeId: employeeId,
  department: department,
  status: 'Active',

  fullName: fullName,
  email: email,
  phoneNumber: phoneNumber,
);
  await ServiceLocator
      .createLabTechnicianUsecase(
    technician,
  );
}
}