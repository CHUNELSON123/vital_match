import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/hospital/data/datasources/hospital_remote_datasource.dart';
import 'package:vital_match/features/hospital/data/models/hospital_model.dart';

class HospitalRemoteDatasourceImpl
    implements HospitalRemoteDatasource {

  final FirebaseFirestore firestore;

  HospitalRemoteDatasourceImpl(this.firestore);

  final String hospitalCollection = 'hospitals';

  @override
  Future<void> createHospital(
    HospitalModel hospital,
  ) async {

    await firestore
        .collection(hospitalCollection)
        .doc(hospital.hospitalId)
        .set(hospital.toMap());
  }

  @override
  Future<HospitalModel?> getHospitalByOwnerId(
    String ownerId,
  ) async {

    final snapshot = await firestore
        .collection(hospitalCollection)
        .where(
          'ownerId',
          isEqualTo: ownerId,
        )
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return HospitalModel.fromFirestore(
      snapshot.docs.first,
    );
  }

  @override
Future<HospitalModel> getHospital(
  String hospitalId,
) async {

  final doc = await firestore
      .collection(hospitalCollection)
      .doc(hospitalId)
      .get();

  if (!doc.exists) {
    throw Exception(
      'Hospital not found',
    );
  }

  return HospitalModel.fromFirestore(
    doc,
  );
}

  @override
  Future<void> updateHospital(
    HospitalModel hospital,
  ) async {

    await firestore
        .collection(hospitalCollection)
        .doc(hospital.hospitalId)
        .update(hospital.toMap());
  }

  @override
  Future<void> deleteHospital(
    String hospitalId,
  ) async {

    await firestore
        .collection(hospitalCollection)
        .doc(hospitalId)
        .delete();
  }
}