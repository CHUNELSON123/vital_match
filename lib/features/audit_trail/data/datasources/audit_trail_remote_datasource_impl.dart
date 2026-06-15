import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/audit_trail_model.dart';

import 'audit_trail_remote_datasource.dart';

class AuditTrailRemoteDatasourceImpl
    implements
        AuditTrailRemoteDatasource {

  final FirebaseFirestore firestore;

  AuditTrailRemoteDatasourceImpl(
    this.firestore,
  );

  final String auditTrailCollection =
      'audit_trails';



  @override
  Future<void> createAuditTrail(
    AuditTrailModel auditTrail,
  ) async {

    await firestore
        .collection(
          auditTrailCollection,
        )
        .doc(
          auditTrail.auditId,
        )
        .set(
          auditTrail.toMap(),
        );
  }



  @override
  Future<AuditTrailModel>
      getAuditTrail(
    String auditId,
  ) async {

    final doc =
        await firestore
            .collection(
              auditTrailCollection,
            )
            .doc(
              auditId,
            )
            .get();

    return AuditTrailModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<AuditTrailModel>>
      getAllAuditTrails() async {

    final snapshot =
        await firestore
            .collection(
              auditTrailCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              AuditTrailModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<List<AuditTrailModel>>
      getAuditTrailsByUser(
    String userId,
  ) async {

    final snapshot =
        await firestore
            .collection(
              auditTrailCollection,
            )
            .where(
              'userId',
              isEqualTo: userId,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              AuditTrailModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateAuditTrail(
    AuditTrailModel auditTrail,
  ) async {

    await firestore
        .collection(
          auditTrailCollection,
        )
        .doc(
          auditTrail.auditId,
        )
        .update(
          auditTrail.toMap(),
        );
  }



  @override
  Future<void> deleteAuditTrail(
    String auditId,
  ) async {

    await firestore
        .collection(
          auditTrailCollection,
        )
        .doc(
          auditId,
        )
        .delete();
  }

  @override
Future<List<AuditTrailModel>>
    getAuditTrailsByHospital(
  String hospitalId,
) async {

  final snapshot =
      await firestore
          .collection(
            'audit_trails',
          )
          .where(
            'hospitalId',
            isEqualTo: hospitalId,
          )
          .orderBy(
            'timestamp',
            descending: true,
          )
          .get();

  return snapshot.docs
      .map(
        (doc) =>
            AuditTrailModel.fromFirestore(
          doc,
        ),
      )
      .toList();
}
}