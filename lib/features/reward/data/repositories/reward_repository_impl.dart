import '../../domain/entities/reward.dart';

import '../../domain/repositories/reward_repository.dart';

import '../datasources/reward_remote_datasource.dart';

import '../models/reward_model.dart';


class RewardRepositoryImpl
    implements RewardRepository {

  final RewardRemoteDatasource
      remoteDatasource;

  RewardRepositoryImpl(
    this.remoteDatasource,
  );




  @override
  Future<void> createReward(
    Reward reward,
  ) async {

    final rewardModel =
        RewardModel(
      rewardId: reward.rewardId,
      donorId: reward.donorId,
      title: reward.title,
      description:
          reward.description,
      pointRequired:
          reward.pointRequired,
      achievedAt:
          reward.achievedAt,
    );

    await remoteDatasource
        .createReward(
      rewardModel,
    );
  }




  @override
  Future<Reward> getReward(
    String rewardId,
  ) async {

    return await remoteDatasource
        .getReward(
      rewardId,
    );
  }




  @override
  Future<List<Reward>>
      getAllRewards() async {

    return await remoteDatasource
        .getAllRewards();
  }




  @override
  Future<List<Reward>>
      getRewardsByDonor(
    String donorId,
  ) async {

    return await remoteDatasource
        .getRewardsByDonor(
      donorId,
    );
  }




  @override
  Future<void> updateReward(
    Reward reward,
  ) async {

    final rewardModel =
        RewardModel(
      rewardId: reward.rewardId,
      donorId: reward.donorId,
      title: reward.title,
      description:
          reward.description,
      pointRequired:
          reward.pointRequired,
      achievedAt:
          reward.achievedAt,
    );

    await remoteDatasource
        .updateReward(
      rewardModel,
    );
  }




  @override
  Future<void> deleteReward(
    String rewardId,
  ) async {

    await remoteDatasource
        .deleteReward(
      rewardId,
    );
  }
}