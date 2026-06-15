import '../entities/health_tip.dart';

import '../repositories/health_tip_repository.dart';

class GetAllHealthTipsUsecase {

  final HealthTipRepository repository;

  GetAllHealthTipsUsecase(
    this.repository,
  );

  Future<List<HealthTip>>
      call() async {

    return await repository
        .getAllHealthTips();
  }
}