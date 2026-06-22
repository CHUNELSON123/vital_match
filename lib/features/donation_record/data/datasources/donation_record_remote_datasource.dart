import '../models/donation_record_model.dart';


abstract class DonationRecordRemoteDatasource {

  Future<void> createDonationRecord(
    DonationRecordModel donationRecord,
  );

  Future<DonationRecordModel>
      getDonationRecord(
    String recordId,
  );

  Future<List<DonationRecordModel>>
      getAllDonationRecords();

  Future<void> updateDonationRecord(
    DonationRecordModel donationRecord,
  );

  Future<void> deleteDonationRecord(
    String recordId,
  );

  Future<List<DonationRecordModel>>
    getDonationRecordsByHospital(
  String hospitalId,
);
}