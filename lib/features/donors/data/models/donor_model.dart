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

//Covert Model to Map
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
      'createdAt':  Timestamp.fromDate(createdAt),
      'lastDonationDate': lastDonationDate != null 
          ? Timestamp.fromDate(lastDonationDate!) 
          : null,
    };
  }

  factory DonorModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return DonorModel(
      donorId: doc.id,
      userId: data['userId'] ?? '',
      bloodGroup: BloodType.values.firstWhere((bloodGroup) => bloodGroup.name == data['bloodGroup'], ),
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
          ? ( data['lastDonationDate'] as Timestamp).toDate() 
          : null,
    );
  }
}
