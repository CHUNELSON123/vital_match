import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/blood_bank/domain/entities/blood_bank.dart';

class BloodBankModel extends BloodBank{

  const BloodBankModel({
    required super.bloodBankId,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.regionCode,
    required super.contactNumber,
    required super.storageCapacity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address':  address,
      'latitude': latitude,
      'longitude': longitude,
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
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      regionCode: data['regionCode'] ?? '',
      contactNumber: data['contactNumber'] ??'',
      storageCapacity: data['storageCapacity'] ?? 0,
    );
  }
}
