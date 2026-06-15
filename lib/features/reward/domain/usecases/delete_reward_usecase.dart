import '../repositories/reward_repository.dart';


class DeleteRewardUsecase {

  final RewardRepository
      repository;

  DeleteRewardUsecase(
    this.repository,
  );


  Future<void> call(
    String rewardId,
  ) async {

    await repository
        .deleteReward(
      rewardId,
    );
  }
}