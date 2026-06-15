class Reward {

  final String rewardId;
  final String donorId;
  final String title;
  final String description;
  final int pointRequired;
  final DateTime achievedAt;

  const Reward({
    required this.rewardId,
    required this.donorId,
    required this.title,
    required this.description,
    required this.pointRequired,
    required this.achievedAt,
  });
}