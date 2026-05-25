import '../entities/alert_response.dart';

import '../repositories/alert_response_repository.dart';


class GetAlertResponseUsecase {

  final AlertResponseRepository
      repository;

  GetAlertResponseUsecase(
    this.repository,
  );



  Future<AlertResponse> call(
    String responseId,
  ) async {

    return await repository
        .getAlertResponse(
      responseId,
    );
  }
}