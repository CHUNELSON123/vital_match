import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String userId;
  final String alertId;
  final String type;
  final String title;
  final String message;
  final bool isRead;
  final Timestamp sentAt;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.alertId,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'alertId': alertId, 
      'title': title, 
      'message': message,
      'isRead': isRead,
      'sentAt': sentAt,
    };
  }

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return NotificationModel(
      notificationId: doc.id,
      userId: data['userId'] ?? '',
      alertId: data['alertId'] ?? '',
      type: data['type'] ?? '',
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      isRead: data['isRead'] ?? false,
      sentAt: data['sentAt'] ?? '',
    );
  }
}
