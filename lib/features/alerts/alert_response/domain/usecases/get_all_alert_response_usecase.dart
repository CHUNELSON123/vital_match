import '../entities/alert_response.dart';

import '../repositories/alert_response_repository.dart';


class GetAllAlertResponsesUsecase {

  final AlertResponseRepository
      repository;

  GetAllAlertResponsesUsecase(
    this.repository,
  );



  Future<List<AlertResponse>>
      call() async {

    return await repository
        .getAllAlertResponses();
  }
}