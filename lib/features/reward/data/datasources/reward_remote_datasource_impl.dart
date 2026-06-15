import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reward_model.dart';

import 'reward_remote_datasource.dart';


class RewardRemoteDatasourceImpl
    implements RewardRemoteDatasource {

  final FirebaseFirestore firestore;

  RewardRemoteDatasourceImpl(
    this.firestore,
  );


  final String rewardCollection =
      'rewards';




  @override
  Future<void> createReward(
    RewardModel reward,
  ) async {

    await firestore
        .collection(
          rewardCollection,
        )
        .doc(
          reward.rewardId,
        )
        .set(
          reward.toMap(),
        );
  }




  @override
  Future<RewardModel> getReward(
    String rewardId,
  ) async {

    final doc =
        await firestore
            .collection(
              rewardCollection,
            )
            .doc(
              rewardId,
            )
            .get();

    return RewardModel.fromFirestore(
      doc,
    );
  }




  @override
  Future<List<RewardModel>>
      getAllRewards() async {

    final snapshot =
        await firestore
            .collection(
              rewardCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              RewardModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }




  @override
  Future<List<RewardModel>>
      getRewardsByDonor(
    String donorId,
  ) async {

    final snapshot =
        await firestore
            .collection(
              rewardCollection,
            )
            .where(
              'donorId',
              isEqualTo: donorId,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              RewardModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }




  @override
  Future<void> updateReward(
    RewardModel reward,
  ) async {

    await firestore
        .collection(
          rewardCollection,
        )
        .doc(
          reward.rewardId,
        )
        .update(
          reward.toMap(),
        );
  }




  @override
  Future<void> deleteReward(
    String rewardId,
  ) async {

    await firestore
        .collection(
          rewardCollection,
        )
        .doc(
          rewardId,
        )
        .delete();
  }
}