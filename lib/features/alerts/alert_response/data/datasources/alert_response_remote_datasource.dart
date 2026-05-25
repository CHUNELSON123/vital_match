import '../models/alert_response_model.dart';

abstract class AlertResponseRemoteDatasource {

  Future<void> createAlertResponse(
    AlertResponseModel alertResponse,
  );



  Future<AlertResponseModel>
      getAlertResponse(
    String responseId,
  );



  Future<List<AlertResponseModel>>
      getAllAlertResponses();



  Future<void> updateAlertResponse(
    AlertResponseModel alertResponse,
  );



  Future<void> deleteAlertResponse(
    String responseId,
  );
}