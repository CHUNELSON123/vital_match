import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/health_tip_model.dart';

import 'health_tip_remote_datasource.dart';

class HealthTipRemoteDatasourceImpl
    implements
        HealthTipRemoteDatasource {

  final FirebaseFirestore firestore;

  HealthTipRemoteDatasourceImpl(
    this.firestore,
  );

  final String healthTipCollection =
      'health_tips';


  @override
  Future<void> createHealthTip(
    HealthTipModel healthTip,
  ) async {

    await firestore
        .collection(
          healthTipCollection,
        )
        .doc(
          healthTip.tipId,
        )
        .set(
          healthTip.toMap(),
        );
  }


  @override
  Future<HealthTipModel>
      getHealthTip(
    String tipId,
  ) async {

    final doc =
        await firestore
            .collection(
              healthTipCollection,
            )
            .doc(
              tipId,
            )
            .get();

    return HealthTipModel
        .fromFirestore(
      doc,
    );
  }


  @override
  Future<List<HealthTipModel>>
      getAllHealthTips() async {

    final snapshot =
        await firestore
            .collection(
              healthTipCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              HealthTipModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }


  @override
  Future<void> updateHealthTip(
    HealthTipModel healthTip,
  ) async {

    await firestore
        .collection(
          healthTipCollection,
        )
        .doc(
          healthTip.tipId,
        )
        .update(
          healthTip.toMap(),
        );
  }


  @override
  Future<void> deleteHealthTip(
    String tipId,
  ) async {

    await firestore
        .collection(
          healthTipCollection,
        )
        .doc(
          tipId,
        )
        .delete();
  }
}