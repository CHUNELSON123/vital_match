import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lab_technician_model.dart';

import 'lab_technician_remote_datasource.dart';


class LabTechnicianRemoteDatasourceImpl
    implements
        LabTechnicianRemoteDatasource {

  final FirebaseFirestore firestore;

  LabTechnicianRemoteDatasourceImpl(
    this.firestore,
  );


  final String
      labTechnicianCollection =
      'lab_technicians';



  @override
  Future<void> createLabTechnician(
    LabTechnicianModel technician,
  ) async {

    await firestore
        .collection(
          labTechnicianCollection,
        )
        .doc(
          technician.technicianId,
        )
        .set(
          technician.toMap(),
        );
  }



  @override
  Future<LabTechnicianModel>
      getLabTechnician(
    String technicianId,
  ) async {

    final doc =
        await firestore
            .collection(
              labTechnicianCollection,
            )
            .doc(
              technicianId,
            )
            .get();

    return LabTechnicianModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<LabTechnicianModel>>
      getAllLabTechnicians() async {

    final snapshot =
        await firestore
            .collection(
              labTechnicianCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              LabTechnicianModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateLabTechnician(
    LabTechnicianModel technician,
  ) async {

    await firestore
        .collection(
          labTechnicianCollection,
        )
        .doc(
          technician.technicianId,
        )
        .update(
          technician.toMap(),
        );
  }



  @override
  Future<void> deleteLabTechnician(
    String technicianId,
  ) async {

    await firestore
        .collection(
          labTechnicianCollection,
        )
        .doc(
          technicianId,
        )
        .delete();
  }

  @override
Future<List<LabTechnicianModel>>
    getLabTechniciansByHospital(
  String hospitalId,
) async {

  final snapshot =
      await firestore
          .collection(
            'lab_technicians',
          )
          .where(
            'hospitalId',
            isEqualTo: hospitalId,
          )
          .get();

  return snapshot.docs
      .map(
        (doc) =>
            LabTechnicianModel
                .fromFirestore(
          doc,
        ),
      )
      .toList();
}
}