import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vital_match/core/enums/blood_type.dart';

import '../../domain/entities/donation_record.dart';


class DonationRecordModel
    extends DonationRecord {

  const DonationRecordModel({
    required super.recordId,
    required super.donorId,
    required super.hospitalId,
    required super.technicianId,
    required super.donationDate,
    required super.bloodUnitsCollected,
    required super.pointsAwarded,
    required super.bloodGroup,
  });


  Map<String, dynamic> toMap() {
    return {
      'donorId': donorId,
      'hospitalId': hospitalId,
      'technicianId': technicianId,
      'donationDate':
          donationDate.toIso8601String(),
      'bloodUnitsCollected':
          bloodUnitsCollected,
      'pointsAwarded':
          pointsAwarded,
      'bloodType':
          bloodGroup.name,
    };
  }


  factory DonationRecordModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return DonationRecordModel(
      recordId: doc.id,
      donorId: data['donorId'] ?? '',
      hospitalId:
          data['hospitalId'] ?? '',
      technicianId:
          data['technicianId'] ?? '',
      donationDate: DateTime.parse(
        data['donationDate'],
      ),
      bloodUnitsCollected:
          data['bloodUnitsCollected'] ?? 0,
      pointsAwarded:
          data['pointsAwarded'] ?? 0,
      bloodGroup:
          BloodType.values.firstWhere(
        (bloodType) =>
            bloodType.name ==
            data['bloodType'],
      ),
    );
  }
}