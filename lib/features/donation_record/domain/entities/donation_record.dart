import 'package:vital_match/core/enums/blood_type.dart';

class DonationRecord {

  final String recordId;

  final String donorId;

  final String hospitalId;

  final String technicianId;

  final DateTime donationDate;

  final int bloodUnitsCollected;

  final int pointsAwarded;

  final BloodType bloodGroup;


  const DonationRecord({
    required this.recordId,
    required this.donorId,
    required this.hospitalId,
    required this.technicianId,
    required this.donationDate,
    required this.bloodUnitsCollected,
    required this.pointsAwarded,
    required this.bloodGroup,
  });
}