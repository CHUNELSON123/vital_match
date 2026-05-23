import 'package:cloud_firestore/cloud_firestore.dart';

class BloodBankModel {
  final String bloodBankId;
  final String hospitalId;
  final String regionCode;
  final String contactNumber;
  final int storageCapacity;

  BloodBankModel({
    required this.bloodBankId,
    required this.hospitalId,
    required this.regionCode,
    required this.contactNumber,
    required this.storageCapacity,
  });

  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'regionCode': regionCode,
      'contactNumber': contactNumber,
      'storageCapacity': storageCapacity,
    };
  }

  factory BloodBankModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return BloodBankModel(
      bloodBankId: doc.id,
      hospitalId: data['hospitalId'] ?? '',
      regionCode: data['regionCode'] ?? '',
      contactNumber: data['contactNumber'] ??'',
      storageCapacity: data['storageCapacity'] ?? 0,
    );
  }
}
