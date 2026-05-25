import '../entities/alert_response.dart';

import '../repositories/alert_response_repository.dart';


class UpdateAlertResponseUsecase {

  final AlertResponseRepository
      repository;

  UpdateAlertResponseUsecase(
    this.repository,
  );



  Future<void> call(
    AlertResponse alertResponse,
  ) async {

    await repository
        .updateAlertResponse(
      alertResponse,
    );
  }
}