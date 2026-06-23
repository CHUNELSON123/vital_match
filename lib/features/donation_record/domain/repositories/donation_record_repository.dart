import '../entities/donation_record.dart';

abstract class DonationRecordRepository {

  Future<void> createDonationRecord(
    DonationRecord donationRecord,
  );

  Future<DonationRecord>
      getDonationRecord(
    String recordId,
  );

  Future<List<DonationRecord>>
      getAllDonationRecords();

  Future<void> updateDonationRecord(
    DonationRecord donationRecord,
  );

  Future<void> deleteDonationRecord(
    String recordId,
  );

  Future<List<DonationRecord>>
    getDonationRecordsByHospital(
  String hospitalId,
);

Future<List<DonationRecord>>
    getPendingDonationRecords();
}