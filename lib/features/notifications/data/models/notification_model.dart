import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/notification_type.dart';

import '../../domain/entities/notification.dart';


class NotificationModel
    extends Notification {

  const NotificationModel({
    required super.notificationId,
    required super.userId,
    required super.alertId,
    required super.type,
    required super.title,
    required super.message,
    required super.isRead,
    required super.sentAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'alertId': alertId,
      'type': type.name,
      'title': title,
      'message': message,
      'isRead': isRead,
      'sentAt': sentAt,
    };
  }


  factory NotificationModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return NotificationModel(
      notificationId: doc.id,
      userId: data['userId'] ?? '',
      alertId: data['alertId'] ?? '',
      type:
          NotificationType.values
              .firstWhere(
        (notificationType) =>
            notificationType.name ==
            data['type'],
      ),
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      isRead:
          data['isRead'] ?? false,
      sentAt: data['sentAt'],
    );
  }
}