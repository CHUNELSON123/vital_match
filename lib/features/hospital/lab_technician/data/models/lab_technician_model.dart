import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/lab_technician.dart';

class LabTechnicianModel extends LabTechnician {
  const LabTechnicianModel({
    required super.technicianId,
    required super.userId,
    required super.hospitalId,
    required super.employeeId,
    required super.department,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hospitalId': hospitalId,
      'employeeId': employeeId,
      'department': department,
      'status': status,
    };
  }

  factory LabTechnicianModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return LabTechnicianModel(
      technicianId: doc.id,
      userId: data['userId'] ?? '',
      hospitalId: data['hospitalId'] ?? '',
      employeeId: data['employeeId'] ?? '',
      department: data['department'] ?? '',
      status: data['status'] ?? 'Active',
    );
  }
}