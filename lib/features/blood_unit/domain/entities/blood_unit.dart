import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/enums/storage_status.dart';

class BloodUnit {

  final String bloodUnitId;

  final String recordId;

  final String? hospitalId;

  final String? bloodBankId;

  final BloodType bloodType;

  final String componentType;

  final int quantity;

  final DateTime collectionDate;

  final DateTime expiryDate;

  final StorageStatus storageStatus;


  const BloodUnit({
    required this.bloodUnitId,
    required this.recordId,
    this.hospitalId,
    this.bloodBankId,
    required this.bloodType,
    required this.componentType,
    required this.quantity,
    required this.collectionDate,
    required this.expiryDate,
    required this.storageStatus,
  });
}