import '../entities/donor.dart';
import '../repositories/donor_repository.dart';

class GetAllDonorsUsecase {
  final DonorRepository repository;

  GetAllDonorsUsecase(
    this.repository,
  );

  Future<List<Donor>> call() async {
    return await repository.getAllDonors();
  }
}