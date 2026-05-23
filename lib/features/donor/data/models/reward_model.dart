import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  final String rewardId;
  final String donorId;
  final String title;
  final String description;
  final int pointEarned;
  final Timestamp achievedAt;

  RewardModel({
    required this.rewardId,
    required this.donorId,
    required this.title,
    required this.description,
    required this.pointEarned,
    required this.achievedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'donorId': donorId,
      'title': title,
      'description': description, 
      'pointEarned': pointEarned,
      'achievedAt': achievedAt,
    };
  }

  factory RewardModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return RewardModel(
      rewardId: doc.id,
      donorId: data['donorId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      pointEarned: data['pointEarned'] ?? 0,
      achievedAt: data['achievedAt'] ?? '',
    );
  }
}
