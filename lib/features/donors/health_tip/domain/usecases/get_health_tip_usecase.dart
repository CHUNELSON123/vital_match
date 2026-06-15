import '../entities/health_tip.dart';

import '../repositories/health_tip_repository.dart';

class GetHealthTipUsecase {

  final HealthTipRepository repository;

  GetHealthTipUsecase(
    this.repository,
  );

  Future<HealthTip> call(
    String tipId,
  ) async {

    return await repository
        .getHealthTip(
      tipId,
    );
  }
}