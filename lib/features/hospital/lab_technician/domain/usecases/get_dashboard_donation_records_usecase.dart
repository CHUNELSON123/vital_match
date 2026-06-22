import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donation_record/domain/repositories/donation_record_repository.dart';

class GetDashboardDonationRecordsUsecase {
  final DonationRecordRepository
      repository;

  GetDashboardDonationRecordsUsecase(
    this.repository,
  );

  Future<List<DonationRecord>>
      call() async {

    return await repository
        .getAllDonationRecords();
  }
}