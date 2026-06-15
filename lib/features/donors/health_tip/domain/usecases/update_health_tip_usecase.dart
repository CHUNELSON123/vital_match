import '../entities/health_tip.dart';

import '../repositories/health_tip_repository.dart';

class UpdateHealthTipUsecase {

  final HealthTipRepository repository;

  UpdateHealthTipUsecase(
    this.repository,
  );

  Future<void> call(
    HealthTip healthTip,
  ) async {

    await repository
        .updateHealthTip(
      healthTip,
    );
  }
}