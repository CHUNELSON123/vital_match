import '../entities/reward.dart';

import '../repositories/reward_repository.dart';


class GetRewardsByDonorUsecase {

  final RewardRepository
      repository;

  GetRewardsByDonorUsecase(
    this.repository,
  );


  Future<List<Reward>> call(
    String donorId,
  ) async {

    return await repository
        .getRewardsByDonor(
      donorId,
    );
  }
}