import 'package:cloud_firestore/cloud_firestore.dart';

class LabTechnicianModel {
  final String technicianId;
  final String userId;
  final String hospitalId;
  final String department;

  LabTechnicianModel({
    required this.technicianId,
    required this.userId,
    required this.hospitalId,
    required this.department,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hospitalId': hospitalId,
      'department': department,
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
      department: data['department'] ?? '',
    );
  }
}
