import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import '../../domain/entities/donation_record.dart';
import 'package:vital_match/core/enums/donation_record_status.dart';

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
    required super.donorWeight,
    required super.status,
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
      'bloodGroup':
          bloodGroup.name,
      'donorWeight':
          donorWeight,
      'status': status.name,
    };
  }


  factory DonationRecordModel
      .fromMap(
    Map<String, dynamic>
        data,
  ) {

    print('DONATION RECORD FROM API');
    print(data);

    return DonationRecordModel(
      recordId: data['recordId'] ?? '',
      donorId: data['donorId'] ?? '',
      hospitalId:
          data['hospitalId'] ?? '',
      technicianId:
          data['technicianId'] ?? '',
      donationDate: _parseDate(
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
      data['bloodGroup'],
      orElse: () => BloodType.oPositive,
),
      donorWeight:
          (data['donorWeight'] ??
                  data['weight'] ??
                  0)
              .toDouble(),

     status:
    DonationRecordStatus.values.firstWhere(
  (status) =>
      status.name ==
      data['status'],
  orElse: () => DonationRecordStatus.verified,
),  
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is Map<String, dynamic>) {
      final seconds = value['_seconds'] ?? value['seconds'] ?? 0;
      return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000,
      );
    }

    return DateTime.parse(value.toString());
  }
}
