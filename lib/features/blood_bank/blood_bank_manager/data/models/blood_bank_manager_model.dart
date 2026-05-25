import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/blood_bank_manager.dart';


class BloodBankManagerModel
    extends BloodBankManager {

  const BloodBankManagerModel({
    required super.managerId,
    required super.userId,
    required super.bloodBankId,
    required super.staffId,
    required super.accessLevel,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bloodBankId': bloodBankId,
      'staffId': staffId,
      'accessLevel': accessLevel,
    };
  }


  factory BloodBankManagerModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return BloodBankManagerModel(
      managerId: doc.id,

      userId:
          data['userId'] ?? '',

      bloodBankId:
          data['bloodBankId'] ?? '',

      staffId:
          data['staffId'] ?? '',

      accessLevel:
          data['accessLevel'] ?? '',
    );
  }
}