import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalModel {
  final String hospitalId;
  final String name;
  final String address;
  final String contactNumber;
  final double latitude;
  final double longitude;
  final int geofenceRadiusKm;

  HospitalModel({
    required this.hospitalId,
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.geofenceRadiusKm,
  });

  Map<String, dynamic> toMap() {
    return {
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
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      geofenceRadiusKm: data['geofenceRadiusKm'] ?? 0,
    );
  }
}
