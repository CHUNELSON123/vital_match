import '../entities/reward.dart';

import '../repositories/reward_repository.dart';


class GetRewardUsecase {

  final RewardRepository
      repository;

  GetRewardUsecase(
    this.repository,
  );


  Future<Reward> call(
    String rewardId,
  ) async {

    return await repository
        .getReward(
      rewardId,
    );
  }
}