import '../entities/donor.dart';
import '../repositories/donor_repository.dart';

class GetDonorUsecase {

  final DonorRepository repository;

  GetDonorUsecase(
    this.repository,
  );

  Future<Donor> call(
    String donorId,
  ) {
    return repository.getDonor(
      donorId,
    );
  }
}