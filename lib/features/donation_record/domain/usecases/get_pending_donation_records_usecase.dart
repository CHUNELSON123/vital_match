import '../entities/donation_record.dart';
import '../repositories/donation_record_repository.dart';

class GetPendingDonationRecordsUsecase {

  final DonationRecordRepository
      repository;

  GetPendingDonationRecordsUsecase(
    this.repository,
  );

  Future<List<DonationRecord>> call() {
    return repository
        .getPendingDonationRecords();
  }
}