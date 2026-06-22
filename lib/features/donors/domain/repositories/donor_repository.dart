import 'package:vital_match/features/donors/domain/entities/donor.dart';

abstract class DonorRepository {
  Future<void> createDonorProfile(Donor donor);

  Future<Donor> getDonorProfile(String donorId);

  Future<void> updateDonorProfile(Donor donor);

  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  });

  Future<List<Donor>> getAllDonors();
}
