import '../entities/alert_response.dart';

import '../repositories/alert_response_repository.dart';

class CreateAlertResponseUseCase {

  final AlertResponseRepository
      repository;

  CreateAlertResponseUseCase(
    this.repository,
  );



  Future<void> call(
    AlertResponse alertResponse,
  ) async {

    await repository
        .createAlertResponse(
      alertResponse,
    );
  }
}