import '../repositories/donor_repository.dart';

class UpdateDonorAvailabilityUsecase {

  final DonorRepository repository;

  UpdateDonorAvailabilityUsecase({
    required this.repository,
  });

  Future<void> call({
    required String donorId,
    required bool isAvailable,
  }) async {

    await repository.updateAvailability(
      donorId: donorId,
      isAvailable: isAvailable,
    );
  }
}