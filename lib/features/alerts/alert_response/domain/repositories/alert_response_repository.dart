import '../entities/alert_response.dart';

abstract class AlertResponseRepository {

  Future<void> createAlertResponse(
    AlertResponse alertResponse,
  );



  Future<AlertResponse>
      getAlertResponse(
    String responseId,
  );



  Future<List<AlertResponse>>
      getAllAlertResponses();



  Future<void> updateAlertResponse(
    AlertResponse alertResponse,
  );



  Future<void> deleteAlertResponse(
    String responseId,
  );
}