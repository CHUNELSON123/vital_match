import 'package:vital_match/features/donors/data/models/donor_model.dart';

abstract class DonorRemoteDatasource {
  Future<void> createDonorProfile(DonorModel donor);

  Future<DonorModel> getDonorProfile(String donorId);

  Future<void> updateDonorProfile(DonorModel donor);

  Future<void> updateAvailability({
    required String donorId,
    required bool isAvailable,
  });

  Future<List<DonorModel>>
    getAllDonors();

  Future<DonorModel> getDonor(
  String donorId,
);
}
