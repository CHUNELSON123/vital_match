import '../repositories/donation_record_repository.dart';


class DeleteDonationRecordUsecase {

  final DonationRecordRepository
      repository;

  DeleteDonationRecordUsecase(
    this.repository,
  );

  Future<void> call(
    String recordId,
  ) async {

    await repository
        .deleteDonationRecord(
      recordId,
    );
  }
}