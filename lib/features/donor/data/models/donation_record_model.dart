import 'package:cloud_firestore/cloud_firestore.dart';

class DonationRecordModel {
  final String recordId;
  final String donorId;
  final String hospitalId;
  final String technicianId;
  final String bloodType;
  final int unitsDonated;
  final int pointAwarded;
  final Timestamp donationDate;

  DonationRecordModel({
    required this.recordId,
    required this.donorId,
    required this.hospitalId,
    required this.technicianId,
    required this.bloodType,
    required this.unitsDonated,
    required this.pointAwarded,
    required this.donationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'donorId': donorId,
      'hospitalId': hospitalId,
      'technicianId': technicianId,
      'bloodType': bloodType,
      'unitsDonated': unitsDonated,
      'pointAwarded': pointAwarded,
      'donationDate': donationDate,
    };
  }

  factory DonationRecordModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return DonationRecordModel(
      recordId: doc.id,
      donorId: data['donorId'] ?? '',
      hospitalId: data['hospitalId'] ?? '',
      technicianId: data['technicianId'] ?? '',
      bloodType: data['bloodType'] ?? '',
      unitsDonated: data['unitsDonated'] ?? 0,
      pointAwarded: data['pointAwarded'] ?? 0,
      donationDate: data['donationDate'] ?? '',
    );
  }
}
