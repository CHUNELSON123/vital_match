import '../../domain/entities/alert_response.dart';

import '../../domain/repositories/alert_response_repository.dart';

import '../datasources/alert_response_remote_datasource.dart';

import '../models/alert_response_model.dart';


class AlertResponseRepositoryImpl
    implements
        AlertResponseRepository {

  final AlertResponseRemoteDatasource
      remoteDatasource;

  AlertResponseRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createAlertResponse(
    AlertResponse alertResponse,
  ) async {

    final alertResponseModel =
        AlertResponseModel.fromEntity(
      alertResponse,
    );

    await remoteDatasource
        .createAlertResponse(
      alertResponseModel,
    );
  }



  @override
  Future<AlertResponse>
      getAlertResponse(
    String responseId,
  ) async {

    return await remoteDatasource
        .getAlertResponse(
      responseId,
    );
  }



  @override
  Future<List<AlertResponse>>
      getAllAlertResponses() async {

    return await remoteDatasource
        .getAllAlertResponses();
  }



  @override
  Future<void> updateAlertResponse(
    AlertResponse alertResponse,
  ) async {

    final alertResponseModel =
        AlertResponseModel.fromEntity(
      alertResponse,
    );

    await remoteDatasource
        .updateAlertResponse(
      alertResponseModel,
    );
  }



  @override
  Future<void> deleteAlertResponse(
    String responseId,
  ) async {

    await remoteDatasource
        .deleteAlertResponse(
      responseId,
    );
  }
}