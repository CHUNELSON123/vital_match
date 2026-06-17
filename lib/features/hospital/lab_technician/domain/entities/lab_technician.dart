class LabTechnician {
  final String technicianId;
  final String userId;
  final String hospitalId;
  final String employeeId;
  final String department;
  final String status;

  final String? fullName;
  final String? email;
  final String? phoneNumber;

  const LabTechnician({
    required this.technicianId,
    required this.userId,
    required this.hospitalId,
    required this.employeeId,
    required this.department,
    required this.status,

    this.fullName,
    this.email,
    this.phoneNumber,
  });
}
