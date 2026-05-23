import '../entities/donor.dart';
import '../repositories/donor_repository.dart';

class CreateDonorProfileUsecase {

  final DonorRepository repository;

  CreateDonorProfileUsecase({
    required this.repository,
  });

  Future<void> call(Donor donor) async {

    await repository.createDonorProfile(
      donor,
    );
  }
}