import '../entities/donor.dart';
import '../repositories/donor_repository.dart';

class GetDonorProfileUsecase {

  final DonorRepository repository;

  GetDonorProfileUsecase({
    required this.repository,
  });

  Future<Donor> call(String donorId) async {

    return await repository.getDonorProfile(
      donorId,
    );
  }
}