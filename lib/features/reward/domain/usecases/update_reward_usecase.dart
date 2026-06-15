import '../entities/reward.dart';

import '../repositories/reward_repository.dart';


class UpdateRewardUsecase {

  final RewardRepository
      repository;

  UpdateRewardUsecase(
    this.repository,
  );


  Future<void> call(
    Reward reward,
  ) async {

    await repository
        .updateReward(
      reward,
    );
  }
}