import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hospital_admin_model.dart';

import 'hospital_admin_remote_datasource.dart';


class HospitalAdminRemoteDatasourceImpl
    implements
        HospitalAdminRemoteDatasource {

  final FirebaseFirestore firestore;

  HospitalAdminRemoteDatasourceImpl(
    this.firestore,
  );


  final String
      hospitalAdminCollection =
          'hospital_admins';



  @override
  Future<void> createHospitalAdmin(
    HospitalAdminModel admin,
  ) async {

    await firestore
        .collection(
          hospitalAdminCollection,
        )
        .doc(
          admin.adminId,
        )
        .set(
          admin.toMap(),
        );
  }



  @override
  Future<HospitalAdminModel>
      getHospitalAdmin(
    String adminId,
  ) async {

    final doc =
        await firestore
            .collection(
              hospitalAdminCollection,
            )
            .doc(
              adminId,
            )
            .get();

    return HospitalAdminModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<HospitalAdminModel>>
      getAllHospitalAdmins() async {

    final snapshot =
        await firestore
            .collection(
              hospitalAdminCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              HospitalAdminModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateHospitalAdmin(
    HospitalAdminModel admin,
  ) async {

    await firestore
        .collection(
          hospitalAdminCollection,
        )
        .doc(
          admin.adminId,
        )
        .update(
          admin.toMap(),
        );
  }



  @override
  Future<void> deleteHospitalAdmin(
    String adminId,
  ) async {

    await firestore
        .collection(
          hospitalAdminCollection,
        )
        .doc(
          adminId,
        )
        .delete();
  }
}