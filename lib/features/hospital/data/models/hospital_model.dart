import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class HospitalModel extends Hospital{

  const HospitalModel({
    required super.hospitalId,
    required super.ownerId,
    required super.name,
    required super.address,
    required super.contactNumber,
    required super.latitude,
    required super.longitude,
    required super.geofenceRadiusKm,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'latitude': latitude,
      'longitude': longitude,
      'geofenceRadiusKm': geofenceRadiusKm,
    };
  }

  factory HospitalModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return HospitalModel(
      hospitalId: doc.id,
      ownerId: data['ownerId'] ?? '',
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      geofenceRadiusKm: data['geofenceRadiusKm'] ?? 0,
    );
  }
}
