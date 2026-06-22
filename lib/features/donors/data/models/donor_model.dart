import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';

class DonorModel extends Donor {
  const DonorModel({
    required super.donorId,
    required super.userId,
    required super.bloodGroup,
    required super.weight,
    required super.gpsLatitude,
    required super.gpsLongitude,
    required super.age,
    required super.pointsBalance,
    required super.isAvailable,
    required super.isVerified,
    required super.dateOfBirth,
    required super.createdAt,
    required super.lastDonationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bloodGroup': bloodGroup.name,
      'weight': weight,
      'gpsLatitude': gpsLatitude,
      'gpsLongitude': gpsLongitude,
      'age': age,
      'pointsBalance': pointsBalance,
      'isAvailable': isAvailable,
      'isVerified': isVerified,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'createdAt': Timestamp.fromDate(createdAt),
      'lastDonationDate': lastDonationDate != null
          ? Timestamp.fromDate(lastDonationDate!)
          : null,
    };
  }

  static BloodType _parseBloodType(String? value) {
    switch (value) {
      case 'A+':
        return BloodType.aPositive;

      case 'A-':
        return BloodType.aNegative;

      case 'B+':
        return BloodType.bPositive;

      case 'B-':
        return BloodType.bNegative;

      case 'AB+':
        return BloodType.abPositive;

      case 'AB-':
        return BloodType.abNegative;

      case 'O+':
        return BloodType.oPositive;

      case 'O-':
        return BloodType.oNegative;

      default:
        return BloodType.oPositive;
    }
  }

  factory DonorModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return DonorModel(
      donorId: doc.id,
      userId: data['userId'] ?? '',
      bloodGroup: _parseBloodType(data['bloodGroup']),
      weight: (data['weight'] ?? 0).toDouble(),
      gpsLatitude: (data['gpsLatitude'] ?? 0).toDouble(),
      gpsLongitude: (data['gpsLongitude'] ?? 0).toDouble(),
      age: data['age'] ?? 0,
      pointsBalance: data['pointsBalance'] ?? 0,
      isAvailable: data['isAvailable'] ?? false,
      isVerified: data['isVerified'] ?? false,
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastDonationDate: data['lastDonationDate'] != null
          ? (data['lastDonationDate'] as Timestamp).toDate()
          : null,
    );
  }

  factory DonorModel.fromJson(Map<String, dynamic> data) {
    return DonorModel(
      donorId: data['donorId'] ?? '',
      userId: data['userId'] ?? '',
      bloodGroup: _parseBloodType(data['bloodGroup']),
      weight: (data['weight'] ?? 0).toDouble(),
      gpsLatitude: (data['gpsLatitude'] ?? 0).toDouble(),
      gpsLongitude: (data['gpsLongitude'] ?? 0).toDouble(),
      age: data['age'] ?? 0,
      pointsBalance: data['pointsBalance'] ?? 0,
      isAvailable: data['isAvailable'] ?? false,
      isVerified: data['isVerified'] ?? false,
      dateOfBirth: _parseDate(data['dateOfBirth']),
      createdAt: _parseDate(data['createdAt']),
      lastDonationDate: data['lastDonationDate'] != null
          ? _parseDate(data['lastDonationDate'])
          : null,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is String) {
      // ISO format
      try {
        return DateTime.parse(value);
      } catch (_) {}

      // d/M/yyyy format
      if (value.contains('/')) {
        final parts = value.split('/');

        if (parts.length == 3) {
          final day = int.parse(parts[0]);

          final month = int.parse(parts[1]);

          final year = int.parse(parts[2]);

          return DateTime(year, month, day);
        }
      }
    }

    if (value is Map<String, dynamic>) {
      final seconds = value['_seconds'] ?? 0;

      return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    }

    throw Exception('Unsupported date format: $value');
  }
}
