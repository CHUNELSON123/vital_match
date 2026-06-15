import 'package:vital_match/core/enums/blood_type.dart';

import 'package:vital_match/core/enums/transfer_order_status.dart';

class TransferOrder {

  final String orderId;

  final String hospitalId;

  final String bloodBankId;

  final String managerId;

  final BloodType bloodType;

  final int quantity;

  final TransferOrderStatus status;

  final DateTime requestDate;



  const TransferOrder({
    required this.orderId,
    required this.hospitalId,
    required this.bloodBankId,
    required this.managerId,
    required this.bloodType,
    required this.quantity,
    required this.status,
    required this.requestDate,
  });
}