import 'package:cloud_firestore/cloud_firestore.dart';

class TransferOrderModel {
  final String orderId;
  final String hospiatlId;
  final String bloodBankId;
  final String managerId;
  final String bloodType;
  final String status;
  final int quantity;
  final Timestamp requestDate;

  TransferOrderModel({
    required this.orderId,
    required this.hospiatlId,
    required this.bloodBankId,
    required this.managerId,
    required this.bloodType,
    required this.status,
    required this.quantity,
    required this.requestDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospiatlId,
      'bloodBankId': bloodBankId,
      'userId': managerId,
      'bloodType': bloodType,
      'status': status,
      'quantity': quantity,
      'requestDate': requestDate,
    };
  }

  factory TransferOrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return TransferOrderModel(
      orderId: doc.id,
      hospiatlId: data['hospitalId'] ?? '',
      bloodBankId: data['bloodBankId'] ?? '',
      managerId: data['managerId'] ?? '',
      bloodType: data['bloodType'] ?? '',
      status: data['status'] ?? '',
      quantity: data['quantity'] ?? 0,
      requestDate: data['requestDate'] ?? '',
    );
  }
}
