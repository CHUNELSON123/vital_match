import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/donation_record_model.dart';

import 'donation_record_remote_datasource.dart';


class DonationRecordRemoteDatasourceImpl
    implements
        DonationRecordRemoteDatasource {

  final FirebaseFirestore firestore;

  DonationRecordRemoteDatasourceImpl(
    this.firestore,
  );


  final String donationRecordCollection =
      'donation_records';



  @override
  Future<void> createDonationRecord(
    DonationRecordModel donationRecord,
  ) async {

    await firestore
        .collection(
          donationRecordCollection,
        )
        .doc(
          donationRecord.recordId,
        )
        .set(
          donationRecord.toMap(),
        );
  }



  @override
  Future<DonationRecordModel>
      getDonationRecord(
    String recordId,
  ) async {

    final doc =
        await firestore
            .collection(
              donationRecordCollection,
            )
            .doc(
              recordId,
            )
            .get();

    return DonationRecordModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<DonationRecordModel>>
      getAllDonationRecords() async {

    final snapshot =
        await firestore
            .collection(
              donationRecordCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              DonationRecordModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateDonationRecord(
    DonationRecordModel donationRecord,
  ) async {

    await firestore
        .collection(
          donationRecordCollection,
        )
        .doc(
          donationRecord.recordId,
        )
        .update(
          donationRecord.toMap(),
        );
  }



  @override
  Future<void> deleteDonationRecord(
    String recordId,
  ) async {

    await firestore
        .collection(
          donationRecordCollection,
        )
        .doc(
          recordId,
        )
        .delete();
  }
}