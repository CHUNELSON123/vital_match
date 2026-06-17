import '../../domain/entities/lab_technician.dart';

class LabTechnicianModel extends LabTechnician {

  const LabTechnicianModel({
    required super.technicianId,
    required super.userId,
    required super.hospitalId,
    required super.employeeId,
    required super.department,
    required super.status,

    super.fullName,
    super.email,
    super.phoneNumber,
  });

 Map<String, dynamic> toMap() {
  final map = <String, dynamic>{
    'hospitalId': hospitalId,
    'employeeId': employeeId,
    'department': department,
    'status': status,
  };

  if (fullName != null) {
    map['fullName'] = fullName;
  }

  if (email != null) {
    map['email'] = email;
  }

  if (phoneNumber != null) {
    map['phoneNumber'] = phoneNumber;
  }

  return map;
}

  factory LabTechnicianModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return LabTechnicianModel(
      technicianId:
          data['technicianId'] ?? '',
      userId:
          data['userId'] ?? '',
      hospitalId:
          data['hospitalId'] ?? '',
      employeeId:
          data['employeeId'] ?? '',
      department:
          data['department'] ?? '',
      status:
          data['status'] ?? 'Active',
      fullName:
          data['fullName'],
      email:
          data['email'],
      phoneNumber:
          data['phoneNumber'],
    );
  }
}