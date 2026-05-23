import '../entities/donor.dart';
import '../repositories/donor_repository.dart';

class UpdateDonorProfileUsecase {

  final DonorRepository repository;

  UpdateDonorProfileUsecase({
    required this.repository,
  });

  Future<void> call(Donor donor) async {

    await repository.updateDonorProfile(
      donor,
    );
  }
}