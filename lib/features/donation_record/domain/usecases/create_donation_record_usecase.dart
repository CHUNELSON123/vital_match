import '../entities/donation_record.dart';

import '../repositories/donation_record_repository.dart';


class CreateDonationRecordUsecase {

  final DonationRecordRepository
      repository;

  CreateDonationRecordUsecase(
    this.repository,
  );

  Future<void> call(
    DonationRecord donationRecord,
  ) async {

    await repository
        .createDonationRecord(
      donationRecord,
    );
  }
}