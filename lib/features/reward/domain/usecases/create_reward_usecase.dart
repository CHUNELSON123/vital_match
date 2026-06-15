import '../entities/reward.dart';

import '../repositories/reward_repository.dart';


class CreateRewardUsecase {

  final RewardRepository
      repository;

  CreateRewardUsecase(
    this.repository,
  );


  Future<void> call(
    Reward reward,
  ) async {

    await repository
        .createReward(
      reward,
    );
  }
}