import 'package:cloud_firestore/cloud_firestore.dart';

class BloodBankManagerModel {
  final String managerId;
  final String userId;
  final String bloodBankId;
  final String staffId;
  final String accessLevel;

  BloodBankManagerModel({
    required this.managerId,
    required this.userId,
    required this.bloodBankId,
    required this.staffId,
    required this.accessLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bloodBankId': bloodBankId,
      'staffId': staffId,
      'accessLevel': accessLevel,
    };
  }

  factory BloodBankManagerModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return BloodBankManagerModel(
      managerId: doc.id,
      userId: data['userId'] ?? '',
      bloodBankId: data['bloodBankId'] ?? '',
      staffId: data['staffId'] ?? '',
      accessLevel: data['accessLevel'] ?? '',
    );
  }
}
