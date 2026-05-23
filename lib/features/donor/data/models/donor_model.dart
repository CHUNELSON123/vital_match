import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
  final String donorId;
  final String userId;
  final String bloodGroup;
  final double weight;
  final double gpsLatitude;
  final double gpsLongitude;
  final int age;
  final int pointBalance;
  final bool isAvailable;
  final bool isVerified;
  final Timestamp dateOfBirth;
  final Timestamp lastDonationDate;

  DonorModel({
    required this.donorId,
    required this.userId,
    required this.bloodGroup,
    required this.weight,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.age,
    required this.pointBalance,
    required this.isAvailable,
    required this.isVerified,
    required this.dateOfBirth,
    required this.lastDonationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bloodGroup': bloodGroup,
      'weight': weight,
      'gpsLatitude': gpsLatitude,
      'gpsLongitude': gpsLatitude,
      'age': age,
      'pointBalance': pointBalance,
      'isAvailable': isAvailable,
      'isVerified': isVerified,
      'dateOfBirth': dateOfBirth,
      'lastDonationDate': lastDonationDate,
    };
  }

  factory DonorModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return DonorModel(
      donorId: doc.id,
      userId: data['userId'] ?? '',
      bloodGroup: data['bloodGroup'] ?? '',
      weight: (data['weight'] ?? 0).toDouble(),
      gpsLatitude: (data['gpsLatitude'] ?? 0).toDouble(),
      gpsLongitude: (data['gpsLongitude'] ?? 0).toDouble(),
      age: data['age'] ?? 0,
      pointBalance: data['pointBalance'] ?? 0,
      isAvailable: data['isAvailable'] ?? false,
      isVerified: data['isVerified'] ?? false,
      dateOfBirth: data['dateOfBirth'] ?? '',
      lastDonationDate: data['lastDonationDate'] ?? '',
    );
  }
}
