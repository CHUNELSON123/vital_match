import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blood_unit_model.dart';

import 'blood_unit_remote_datasource.dart';

class BloodUnitRemoteDatasourceImpl
    implements BloodUnitRemoteDatasource {

  final FirebaseFirestore firestore;

  BloodUnitRemoteDatasourceImpl(
    this.firestore,
  );

  final String bloodUnitCollection =
      'blood_units';


  @override
  Future<void> createBloodUnit(
    BloodUnitModel bloodUnit,
  ) async {

    await firestore
        .collection(bloodUnitCollection)
        .doc(bloodUnit.bloodUnitId)
        .set(bloodUnit.toMap());
  }


  @override
  Future<BloodUnitModel> getBloodUnit(
    String bloodUnitId,
  ) async {

    final doc = await firestore
        .collection(bloodUnitCollection)
        .doc(bloodUnitId)
        .get();

    return BloodUnitModel.fromFirestore(
      doc,
    );
  }


  @override
  Future<void> updateBloodUnit(
    BloodUnitModel bloodUnit,
  ) async {

    await firestore
        .collection(bloodUnitCollection)
        .doc(bloodUnit.bloodUnitId)
        .update(bloodUnit.toMap());
  }


  @override
  Future<void> deleteBloodUnit(
    String bloodUnitId,
  ) async {

    await firestore
        .collection(bloodUnitCollection)
        .doc(bloodUnitId)
        .delete();
  }
}