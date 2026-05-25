import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/alert_response_model.dart';

import 'alert_response_remote_datasource.dart';


class AlertResponseRemoteDatasourceImpl
    implements
        AlertResponseRemoteDatasource {

  final FirebaseFirestore firestore;

  AlertResponseRemoteDatasourceImpl(
    this.firestore,
  );


  final String alertResponseCollection =
      'alert_responses';



  @override
  Future<void> createAlertResponse(
    AlertResponseModel alertResponse,
  ) async {

    await firestore
        .collection(
          alertResponseCollection,
        )
        .doc(
          alertResponse.responseId,
        )
        .set(
          alertResponse.toMap(),
        );
  }



  @override
  Future<AlertResponseModel>
      getAlertResponse(
    String responseId,
  ) async {

    final doc =
        await firestore
            .collection(
              alertResponseCollection,
            )
            .doc(
              responseId,
            )
            .get();

    return AlertResponseModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<AlertResponseModel>>
      getAllAlertResponses() async {

    final snapshot =
        await firestore
            .collection(
              alertResponseCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              AlertResponseModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateAlertResponse(
    AlertResponseModel alertResponse,
  ) async {

    await firestore
        .collection(
          alertResponseCollection,
        )
        .doc(
          alertResponse.responseId,
        )
        .update(
          alertResponse.toMap(),
        );
  }



  @override
  Future<void> deleteAlertResponse(
    String responseId,
  ) async {

    await firestore
        .collection(
          alertResponseCollection,
        )
        .doc(
          responseId,
        )
        .delete();
  }
}