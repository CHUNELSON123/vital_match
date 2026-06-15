import '../entities/reward.dart';

import '../repositories/reward_repository.dart';


class GetAllRewardsUsecase {

  final RewardRepository
      repository;

  GetAllRewardsUsecase(
    this.repository,
  );


  Future<List<Reward>>
      call() async {

    return await repository
        .getAllRewards();
  }
}