import '../entities/health_tip.dart';

import '../repositories/health_tip_repository.dart';

class CreateHealthTipUsecase {

  final HealthTipRepository repository;

  CreateHealthTipUsecase(
    this.repository,
  );

  Future<void> call(
    HealthTip healthTip,
  ) async {

    await repository
        .createHealthTip(
      healthTip,
    );
  }
}