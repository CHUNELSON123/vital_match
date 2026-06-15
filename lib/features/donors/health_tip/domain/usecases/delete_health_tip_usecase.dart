import '../repositories/health_tip_repository.dart';

class DeleteHealthTipUsecase {

  final HealthTipRepository repository;

  DeleteHealthTipUsecase(
    this.repository,
  );

  Future<void> call(
    String tipId,
  ) async {

    await repository
        .deleteHealthTip(
      tipId,
    );
  }
}