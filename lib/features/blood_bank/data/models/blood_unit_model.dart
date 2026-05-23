import 'package:cloud_firestore/cloud_firestore.dart';

class BloodUnitModel {
  final String bloodUnitId;
  final String recordId;
  final String? hospitalId;
  final String? bloodBankId;
  final String bloodType;
  final String componentType;
  final String status;
  final int quantity;
  final Timestamp collectionDate;
  final Timestamp expiryDate;

  BloodUnitModel({
    required this.bloodUnitId,
    required this.recordId,
    required this.hospitalId,
    required this.bloodBankId,
    required this.bloodType,
    required this.componentType,
    required this.status,
    required this.quantity,
    required this.collectionDate,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'hospitalId': hospitalId,
      'bloodBankId': bloodBankId,
      'bloodType': bloodType, 
      'componentType': componentType,
      'status': status, 
      'quantity': quantity,
      'collectionDate': collectionDate,
      'expiryDate': expiryDate,
    };
  }

  factory BloodUnitModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return BloodUnitModel(
      bloodUnitId: doc.id,
      recordId: data['recordId'] ?? '',
      hospitalId: data['hospitalId'] ?? '',
      bloodBankId: data['bloodBankId'] ?? '',
      bloodType: data['bloodType'] ?? '',
      componentType: data['componentType'] ?? '',
      status: data['status'] ?? '',
      quantity: data['quantity'] ?? 0,
      collectionDate: data['collectionDate'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
    );
  }
}
