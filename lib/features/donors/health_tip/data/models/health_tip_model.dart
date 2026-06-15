import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/health_tip.dart';

class HealthTipModel
    extends HealthTip {

  const HealthTipModel({
    required super.tipId,
    required super.title,
    required super.content,
    required super.category,
  });


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
    };
  }


  factory HealthTipModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
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