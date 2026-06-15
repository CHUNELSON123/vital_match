import '../models/reward_model.dart';


abstract class RewardRemoteDatasource {

  Future<void> createReward(
    RewardModel reward,
  );

  Future<RewardModel> getReward(
    String rewardId,
  );

  Future<List<RewardModel>>
      getAllRewards();

  Future<List<RewardModel>>
      getRewardsByDonor(
    String donorId,
  );

  Future<void> updateReward(
    RewardModel reward,
  );

  Future<void> deleteReward(
    String rewardId,
  );
}