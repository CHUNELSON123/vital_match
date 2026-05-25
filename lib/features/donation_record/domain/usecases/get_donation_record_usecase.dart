import '../entities/donation_record.dart';

import '../repositories/donation_record_repository.dart';


class GetDonationRecordUsecase {

  final DonationRecordRepository
      repository;

  GetDonationRecordUsecase(
    this.repository,
  );

  Future<DonationRecord> call(
    String recordId,
  ) async {

    return await repository
        .getDonationRecord(
      recordId,
    );
  }
}