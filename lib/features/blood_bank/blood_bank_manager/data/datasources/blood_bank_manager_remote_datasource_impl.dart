import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blood_bank_manager_model.dart';

import 'blood_bank_manager_remote_datasource.dart';


class
    BloodBankManagerRemoteDatasourceImpl
    implements
        BloodBankManagerRemoteDatasource {

  final FirebaseFirestore firestore;

  BloodBankManagerRemoteDatasourceImpl(
    this.firestore,
  );


  final String
      bloodBankManagerCollection =
          'blood_bank_managers';



  @override
  Future<void>
      createBloodBankManager(
    BloodBankManagerModel manager,
  ) async {

    await firestore
        .collection(
          bloodBankManagerCollection,
        )
        .doc(
          manager.managerId,
        )
        .set(
          manager.toMap(),
        );
  }



  @override
  Future<BloodBankManagerModel>
      getBloodBankManager(
    String managerId,
  ) async {

    final doc =
        await firestore
            .collection(
              bloodBankManagerCollection,
            )
            .doc(
              managerId,
            )
            .get();

    return BloodBankManagerModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<BloodBankManagerModel>>
      getAllBloodBankManagers() async {

    final snapshot =
        await firestore
            .collection(
              bloodBankManagerCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              BloodBankManagerModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void>
      updateBloodBankManager(
    BloodBankManagerModel manager,
  ) async {

    await firestore
        .collection(
          bloodBankManagerCollection,
        )
        .doc(
          manager.managerId,
        )
        .update(
          manager.toMap(),
        );
  }



  @override
  Future<void>
      deleteBloodBankManager(
    String managerId,
  ) async {

    await firestore
        .collection(
          bloodBankManagerCollection,
        )
        .doc(
          managerId,
        )
        .delete();
  }
}