class BloodBank {

  final String bloodBankId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String regionCode;
  final int storageCapacity;
  final String contactNumber;


  const BloodBank({
    required this.bloodBankId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.regionCode,
    required this.storageCapacity,
    required this.contactNumber,
  });
}