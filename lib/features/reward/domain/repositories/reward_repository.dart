import '../entities/reward.dart';


abstract class RewardRepository {

  Future<void> createReward(
    Reward reward,
  );

  Future<Reward> getReward(
    String rewardId,
  );

  Future<List<Reward>>
      getAllRewards();

  Future<List<Reward>>
      getRewardsByDonor(
    String donorId,
  );

  Future<void> updateReward(
    Reward reward,
  );

  Future<void> deleteReward(
    String rewardId,
  );
}