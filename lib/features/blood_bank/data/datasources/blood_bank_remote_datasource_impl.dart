import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blood_bank_model.dart';

import 'blood_bank_remote_datasource.dart';

class BloodBankRemoteDatasourceImpl
    implements BloodBankRemoteDatasource {

  final FirebaseFirestore firestore;

  BloodBankRemoteDatasourceImpl(
    this.firestore,
  );

  final String bloodBankCollection = 'blood_banks';


  @override
  Future<void> createBloodBank(
    BloodBankModel bloodBank,
  ) async {

    await firestore
        .collection(bloodBankCollection)
        .doc(bloodBank.bloodBankId)
        .set(bloodBank.toMap());
  }


  @override
  Future<BloodBankModel> getBloodBank(
    String bloodBankId,
  ) async {

    final doc = await firestore
        .collection(bloodBankCollection)
        .doc(bloodBankId)
        .get();

    return BloodBankModel.fromFirestore(doc);
  }


  @override
  Future<void> updateBloodBank(
    BloodBankModel bloodBank,
  ) async {

    await firestore
        .collection(bloodBankCollection)
        .doc(bloodBank.bloodBankId)
        .update(bloodBank.toMap());
  }


  @override
  Future<void> deleteBloodBank(
    String bloodBankId,
  ) async {

    await firestore
        .collection(bloodBankCollection)
        .doc(bloodBankId)
        .delete();
  }
}