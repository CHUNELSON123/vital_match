class Hospital {
  final String hospitalId;
  final String name;
  final String address;
  final String contactNumber;
  final double latitude;
  final double longitude;
  final int geofenceRadiusKm;

  const Hospital({
    required this.hospitalId,
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.geofenceRadiusKm,
  });
}