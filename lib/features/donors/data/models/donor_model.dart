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
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'lastDonationDate': lastDonationDate != null
          ? lastDonationDate!.toIso8601String()
          : null,
    };
  }

  static String _bloodTypeToString(
    BloodType bloodType,
  ) {
    switch (bloodType) {
      case BloodType.aPositive:
        return 'A+';

      case BloodType.aNegative:
        return 'A-';

      case BloodType.bPositive:
        return 'B+';

      case BloodType.bNegative:
        return 'B-';

      case BloodType.abPositive:
        return 'AB+';

      case BloodType.abNegative:
        return 'AB-';

      case BloodType.oPositive:
        return 'O+';

      case BloodType.oNegative:
        return 'O-';
    }
  }

  static BloodType _parseBloodType(String? value) {
    switch (value) {
      case 'aPositive':
      case 'A+':
        return BloodType.aPositive;

      case 'aNegative':
      case 'A-':
        return BloodType.aNegative;

      case 'bPositive':
      case 'B+':
        return BloodType.bPositive;

      case 'bNegative':
      case 'B-':
        return BloodType.bNegative;

      case 'abPositive':
      case 'AB+':
        return BloodType.abPositive;

      case 'abNegative':
      case 'AB-':
        return BloodType.abNegative;

      case 'oPositive':
      case 'O+':
        return BloodType.oPositive;

      case 'oNegative':
      case 'O-':
        return BloodType.oNegative;

      default:
        return BloodType.oPositive;
    }
  }

  factory DonorModel.fromMap(Map<String, dynamic> data) {
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

  factory DonorModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return DonorModel(
      donorId: data['donorId'] ?? '',
      userId: data['userId'] ?? '',
      bloodGroup: _parseBloodType(
        data['bloodGroup'],
      ),
      weight: (data['weight'] ?? 0).toDouble(),
      gpsLatitude:
          (data['gpsLatitude'] ?? 0).toDouble(),
      gpsLongitude:
          (data['gpsLongitude'] ?? 0).toDouble(),
      age: data['age'] ?? 0,
      pointsBalance:
          data['pointsBalance'] ?? 0,
      isAvailable:
          data['isAvailable'] ?? false,
      isVerified:
          data['isVerified'] ?? false,
      dateOfBirth:
          _parseDate(data['dateOfBirth']),
      createdAt:
          _parseDate(data['createdAt']),
      lastDonationDate:
          data['lastDonationDate'] != null
              ? _parseDate(
                  data['lastDonationDate'],
                )
              : null,
    );
  }

  static DateTime _parseDate(
    dynamic value,
  ) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {}

      if (value.contains('/')) {
        final parts = value.split('/');

        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);

          return DateTime(
            year,
            month,
            day,
          );
        }
      }
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is Map<String, dynamic>) {
      final seconds =
          value['_seconds'] ?? 0;

      return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000,
      );
    }

    throw Exception(
      'Unsupported date format: $value',
    );
  }
}
