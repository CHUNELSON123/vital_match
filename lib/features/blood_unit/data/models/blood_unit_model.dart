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
      'bloodGroup': bloodType.name,
      'componentType': componentType,
      'storageStatus': storageStatus.name, 
      'quantity': quantity,
      'collectionDate': collectionDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

 factory BloodUnitModel.fromMap(
  Map<String, dynamic> data,
) {

  print('BLOOD UNIT FROM API');
  print(data);

  final bloodTypeValue =
      data['bloodType'] ??
      data['bloodGroup'];

  final storageStatusValue =
      data['storageStatus'];

  print('bloodType value = $bloodTypeValue');
  print('storageStatus value = $storageStatusValue');

  return BloodUnitModel(
    bloodUnitId:
        data['bloodUnitId'] ??
        data['id'] ??
        '',

    recordId:
        data['recordId'] ??
        '',

    hospitalId:
        data['hospitalId'],

    bloodBankId:
        data['bloodBankId'],

    bloodType:
        BloodType.values.firstWhere(
      (bloodType) =>
          bloodType.name ==
          bloodTypeValue,
      orElse: () =>
          BloodType.oPositive,
    ),

    componentType:
        data['componentType'] ??
        'Whole Blood',

    storageStatus:
        StorageStatus.values.firstWhere(
      (storageStatus) =>
          storageStatus.name ==
          storageStatusValue,
      orElse: () =>
          StorageStatus.available,
    ),

    quantity:
        (data['quantity'] ?? 0) as int,

    collectionDate:
        DateTime.parse(
      data['collectionDate'],
    ),

    expiryDate:
        DateTime.parse(
      data['expiryDate'],
    ),
  );
}
}
