 import 'package:vital_match/core/enums/blood_type.dart';

class Donor {
  final String donorId;
  final String userId;
  final BloodType bloodGroup;
  final double weight;
  final double gpsLatitude;
  final double gpsLongitude;
  final int age;
  final int pointsBalance;
  final bool isAvailable;
  final bool isVerified;
  final DateTime dateOfBirth;
  final DateTime createdAt;
  final DateTime? lastDonationDate;

  const Donor({
    required this.donorId,
    required this.userId,
    required this.bloodGroup,
    required this.weight,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.age,
    required this.pointsBalance,
    required this.isAvailable,
    required this.isVerified,
    required this.dateOfBirth,
    required this.createdAt,
    this.lastDonationDate,
  });
}
