import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalAdminModel {
  final String adminId;
  final String userId;
  final String hospitalId;
  final String adminLevel;

  HospitalAdminModel({
    required this.adminId,
    required this.userId,
    required this.hospitalId,
    required this.adminLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hospitalId': hospitalId,
      'adminLevel': adminLevel,
    };
  }

  factory HospitalAdminModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, ) {
    final data = doc.data()!;

    return HospitalAdminModel(
      adminId: doc.id,
      userId: data['userId'] ?? '',
      hospitalId: data['hospitalId'] ?? '',
      adminLevel: data['adminLevel'] ?? '',
    );
  }
}
