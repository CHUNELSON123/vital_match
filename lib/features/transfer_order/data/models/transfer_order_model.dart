import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vital_match/core/enums/blood_type.dart';

import 'package:vital_match/core/enums/transfer_order_status.dart';

import '../../domain/entities/transfer_order.dart';


class TransferOrderModel
    extends TransferOrder {

  const TransferOrderModel({
    required super.orderId,
    required super.hospitalId,
    required super.bloodBankId,
    required super.managerId,
    required super.bloodType,
    required super.quantity,
    required super.status,
    required super.requestDate,
  });


  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'bloodBankId':
          bloodBankId,
      'managerId': managerId,
      'bloodType':
          bloodType.name,
      'quantity': quantity,
      'status': status.name,
      'requestDate':
          requestDate
              .toIso8601String(),
    };
  }


  factory TransferOrderModel
      .fromFirestore(
    DocumentSnapshot<
            Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return TransferOrderModel(
      orderId: doc.id,
      hospitalId:
          data['hospitalId'] ?? '',
      bloodBankId:
          data['bloodBankId'] ?? '',
      managerId:
          data['managerId'] ?? '',
      bloodType:
          BloodType.values.firstWhere(
        (bloodType) =>
            bloodType.name ==
            data['bloodType'],
      ),
      quantity:
          data['quantity'] ?? 0,
      status:
          TransferOrderStatus
              .values
              .firstWhere(
        (status) =>
            status.name ==
            data['status'],
      ),
      requestDate:
          DateTime.parse(
        data['requestDate'],
      ),
    );
  }
}