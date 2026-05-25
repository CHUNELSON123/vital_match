import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/enums/alert_response_status.dart';

import '../../domain/entities/alert_response.dart';

class AlertResponseModel
    extends AlertResponse {

  const AlertResponseModel({

    required super.responseId,

    required super.alertId,

    required super.donorId,

    required super.responseStatus,

    required super.responseDate,
  });



  Map<String, dynamic> toMap() {

    return {

      'responseId':
          responseId,

      'alertId':
          alertId,

      'donorId':
          donorId,

      'responseStatus':
          responseStatus.name,

      'responseDate':
          responseDate
              .toIso8601String(),
    };
  }



  factory AlertResponseModel
      .fromFirestore(
    DocumentSnapshot doc,
  ) {

    final data =
        doc.data()
            as Map<String, dynamic>;

    return AlertResponseModel(

      responseId:
          data['responseId'],

      alertId:
          data['alertId'],

      donorId:
          data['donorId'],

      responseStatus:
          AlertResponseStatus
              .values
              .firstWhere(
        (status) =>
            status.name ==
            data[
                'responseStatus'],
      ),

      responseDate:
          DateTime.parse(
        data['responseDate'],
      ),
    );
  }



  factory AlertResponseModel
      .fromEntity(
    AlertResponse alertResponse,
  ) {

    return AlertResponseModel(

      responseId:
          alertResponse
              .responseId,

      alertId:
          alertResponse.alertId,

      donorId:
          alertResponse.donorId,

      responseStatus:
          alertResponse
              .responseStatus,

      responseDate:
          alertResponse
              .responseDate,
    );
  }
}