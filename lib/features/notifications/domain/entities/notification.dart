import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/notification_type.dart';


class Notification {

  final String notificationId;
  final String userId;
  final String alertId;
  final NotificationType type;
  final String title;
  final String message;
  final bool isRead;
  final Timestamp sentAt;

  const Notification({
    required this.notificationId,
    required this.userId,
    required this.alertId,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.sentAt,
  });
}