import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/enums/storage_status.dart';
import 'package:vital_match/features/blood_unit/domain/entities/blood_unit.dart';

class BloodUnitModel extends BloodUnit {

  const BloodUnitModel({
    required super.bloodUnitId,
    required super.recordId,
    super.hospitalId,
    super.bloodBankId,
    required super.bloodType,
    required super.componentType,
    required super.storageStatus,
    required super.quantity,
    required super.collectionDate,
    required super.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'hospitalId': hospitalId,
      'bloodBankId': bloodBankId,
      'bloodType': bloodType.name, 
      'componentType': componentType,
      'storageStatus': storageStatus.name, 
      'quantity': quantity,
      'collectionDate': collectionDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  factory BloodUnitModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return BloodUnitModel(
      bloodUnitId: doc.id,
      recordId: data['recordId'] ?? '',
      hospitalId: data['hospitalId'],
      bloodBankId: data['bloodBankId'],
      bloodType: BloodType.values.firstWhere((bloodType) =>
        bloodType.name ==
        data['bloodType'], 
        ),
      componentType: data['componentType'] ?? '',
      storageStatus: StorageStatus.values.firstWhere((storageStatus) =>
        storageStatus.name ==
        data['storageStatus'], 
        ),
      quantity: data['quantity'] ?? 0,
      collectionDate: DateTime.parse(data['collectionDate'],
      ),
      expiryDate: DateTime.parse(data['expiryDate'],
      ),
    );
  }
}
