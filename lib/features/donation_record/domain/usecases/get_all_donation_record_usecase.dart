import '../entities/donation_record.dart';

import '../repositories/donation_record_repository.dart';


class GetAllDonationRecordsUsecase {

  final DonationRecordRepository
      repository;

  GetAllDonationRecordsUsecase(
    this.repository,
  );

  Future<List<DonationRecord>>
      call() async {

    return await repository
        .getAllDonationRecords();
  }
}