import '../../domain/entities/donation_record.dart';

import '../../domain/repositories/donation_record_repository.dart';

import '../datasources/donation_record_remote_datasource.dart';

import '../models/donation_record_model.dart';


class DonationRecordRepositoryImpl
    implements DonationRecordRepository {

  final DonationRecordRemoteDatasource
      remoteDatasource;

  DonationRecordRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createDonationRecord(
    DonationRecord donationRecord,
  ) async {

    final donationRecordModel =
        DonationRecordModel(
      recordId:
          donationRecord.recordId,

      donorId:
          donationRecord.donorId,

      hospitalId:
          donationRecord.hospitalId,

      technicianId:
          donationRecord.technicianId,

      donationDate:
          donationRecord.donationDate,

      bloodUnitsCollected:
          donationRecord
              .bloodUnitsCollected,

      pointsAwarded:
          donationRecord
              .pointsAwarded,

      bloodGroup:
          donationRecord.bloodGroup,
      
      status: donationRecord.status,
    );

    await remoteDatasource
        .createDonationRecord(
      donationRecordModel,
    );
  }



  @override
  Future<DonationRecord>
      getDonationRecord(
    String recordId,
  ) async {

    return await remoteDatasource
        .getDonationRecord(
      recordId,
    );
  }



  @override
  Future<List<DonationRecord>>
      getAllDonationRecords() async {

    return await remoteDatasource
        .getAllDonationRecords();
  }



  @override
  Future<void> updateDonationRecord(
    DonationRecord donationRecord,
  ) async {

    final donationRecordModel =
        DonationRecordModel(
      recordId:
          donationRecord.recordId,

      donorId:
          donationRecord.donorId,

      hospitalId:
          donationRecord.hospitalId,

      technicianId:
          donationRecord.technicianId,

      donationDate:
          donationRecord.donationDate,

      bloodUnitsCollected:
          donationRecord
              .bloodUnitsCollected,

      pointsAwarded:
          donationRecord
              .pointsAwarded,

      bloodGroup:
          donationRecord.bloodGroup,

      status: donationRecord.status,
    );

    await remoteDatasource
        .updateDonationRecord(
      donationRecordModel,
    );
  }



  @override
  Future<void> deleteDonationRecord(
    String recordId,
  ) async {

    await remoteDatasource
        .deleteDonationRecord(
      recordId,
    );
  }

  @override
Future<List<DonationRecord>>
    getDonationRecordsByHospital(
  String hospitalId,
) async {

  return await remoteDatasource
      .getDonationRecordsByHospital(
    hospitalId,
  );
}
}