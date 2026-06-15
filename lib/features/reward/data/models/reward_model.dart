import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/reward.dart';


class RewardModel extends Reward {

  const RewardModel({
    required super.rewardId,
    required super.donorId,
    required super.title,
    required super.description,
    required super.pointRequired,
    required super.achievedAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'donorId': donorId,
      'title': title,
      'description': description,
      'pointRequired': pointRequired,
      'achievedAt':
          achievedAt.toIso8601String(),
    };
  }


  factory RewardModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return RewardModel(
      rewardId: doc.id,
      donorId: data['donorId'] ?? '',
      title: data['title'] ?? '',
      description:
          data['description'] ?? '',
      pointRequired:
          data['pointRequired'] ?? 0,
      achievedAt: DateTime.parse(
        data['achievedAt'],
      ),
    );
  }
}