import '../entities/donation_record.dart';

import '../repositories/donation_record_repository.dart';


class UpdateDonationRecordUsecase {

  final DonationRecordRepository
      repository;

  UpdateDonationRecordUsecase(
    this.repository,
  );

  Future<void> call(
    DonationRecord donationRecord,
  ) async {

    await repository
        .updateDonationRecord(
      donationRecord,
    );
  }
}