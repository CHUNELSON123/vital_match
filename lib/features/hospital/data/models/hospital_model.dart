import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class HospitalModel extends Hospital {
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
      'hospitalId': hospitalId,
      'ownerId': ownerId,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'latitude': latitude,
      'longitude': longitude,
      'geofenceRadiusKm': geofenceRadiusKm,
    };
  }

  factory HospitalModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return HospitalModel(
      hospitalId:
          data['hospitalId'] ?? '',
      ownerId:
          data['ownerId'] ?? '',
      name:
          data['name'] ?? '',
      address:
          data['address'] ?? '',
      contactNumber:
          data['contactNumber'] ?? '',
      latitude:
          (data['latitude'] ?? 0)
              .toDouble(),
      longitude:
          (data['longitude'] ?? 0)
              .toDouble(),
      geofenceRadiusKm:
          data['geofenceRadiusKm'] ?? 0,
    );
  }
}