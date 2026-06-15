import '../entities/notification.dart';


abstract class NotificationRepository {

  Future<void> createNotification(
    Notification notification,
  );

  Future<Notification>
      getNotification(
    String notificationId,
  );

  Future<List<Notification>>
      getAllNotifications();

  Future<List<Notification>>
      getNotificationsByUser(
    String userId,
  );

  Future<void> updateNotification(
    Notification notification,
  );

  Future<void> deleteNotification(
    String notificationId,
  );

  Future<void> markAsRead(
    String notificationId,
  );
}