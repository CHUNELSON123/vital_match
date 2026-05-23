import 'package:cloud_firestore/cloud_firestore.dart';

class HealthTipModel {
  final String tipId;
  final String title;
  final String content;
  final String category;

  HealthTipModel({
    required this.tipId,
    required this.title,
    required this.content,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'category': category};
  }

  factory HealthTipModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return HealthTipModel(
      tipId: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      category: data['category'] ?? '',
    );
  }
}
