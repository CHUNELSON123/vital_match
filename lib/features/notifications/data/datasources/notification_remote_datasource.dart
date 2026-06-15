import '../models/notification_model.dart';


abstract class NotificationRemoteDatasource {

  Future<void> createNotification(
    NotificationModel notification,
  );

  Future<NotificationModel>
      getNotification(
    String notificationId,
  );

  Future<List<NotificationModel>>
      getAllNotifications();

  Future<List<NotificationModel>>
      getNotificationsByUser(
    String userId,
  );

  Future<void> updateNotification(
    NotificationModel notification,
  );

  Future<void> deleteNotification(
    String notificationId,
  );

  Future<void> markAsRead(
    String notificationId,
  );
}