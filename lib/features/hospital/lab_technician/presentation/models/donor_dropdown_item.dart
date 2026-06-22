import 'package:vital_match/features/donors/domain/entities/donor.dart';

class DonorDropdownItem {
  final Donor donor;
  final String fullName;
  final String phoneNumber;

  const DonorDropdownItem({required this.donor, required this.fullName, required this.phoneNumber,});
}
