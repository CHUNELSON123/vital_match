import '../repositories/alert_response_repository.dart';


class DeleteAlertResponseUsecase {

  final AlertResponseRepository
      repository;

  DeleteAlertResponseUsecase(
    this.repository,
  );



  Future<void> call(
    String responseId,
  ) async {

    await repository
        .deleteAlertResponse(
      responseId,
    );
  }
}