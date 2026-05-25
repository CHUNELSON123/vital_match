import '../../../../../core/enums/alert_response_status.dart';

class AlertResponse {

  final String responseId;

  final String alertId;

  final String donorId;

  final AlertResponseStatus responseStatus;

  final DateTime responseDate;



  const AlertResponse({

    required this.responseId,

    required this.alertId,

    required this.donorId,

    required this.responseStatus,

    required this.responseDate,
  });
}