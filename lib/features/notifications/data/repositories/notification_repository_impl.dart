import '../../domain/entities/notification.dart';

import '../../domain/repositories/notification_repository.dart';

import '../datasources/notification_remote_datasource.dart';

import '../models/notification_model.dart';


class NotificationRepositoryImpl
    implements
        NotificationRepository {

  final NotificationRemoteDatasource
      remoteDatasource;

  NotificationRepositoryImpl(
    this.remoteDatasource,
  );




  @override
  Future<void> createNotification(
    Notification notification,
  ) async {

    final notificationModel =
        NotificationModel(
      notificationId:
          notification.notificationId,
      userId: notification.userId,
      alertId: notification.alertId,
      type: notification.type,
      title: notification.title,
      message:
          notification.message,
      isRead: notification.isRead,
      sentAt: notification.sentAt,
    );

    await remoteDatasource
        .createNotification(
      notificationModel,
    );
  }




  @override
  Future<Notification>
      getNotification(
    String notificationId,
  ) async {

    return await remoteDatasource
        .getNotification(
      notificationId,
    );
  }




  @override
  Future<List<Notification>>
      getAllNotifications() async {

    return await remoteDatasource
        .getAllNotifications();
  }




  @override
  Future<List<Notification>>
      getNotificationsByUser(
    String userId,
  ) async {

    return await remoteDatasource
        .getNotificationsByUser(
      userId,
    );
  }




  @override
  Future<void> updateNotification(
    Notification notification,
  ) async {

    final notificationModel =
        NotificationModel(
      notificationId:
          notification.notificationId,
      userId: notification.userId,
      alertId: notification.alertId,
      type: notification.type,
      title: notification.title,
      message:
          notification.message,
      isRead: notification.isRead,
      sentAt: notification.sentAt,
    );

    await remoteDatasource
        .updateNotification(
      notificationModel,
    );
  }




  @override
  Future<void> deleteNotification(
    String notificationId,
  ) async {

    await remoteDatasource
        .deleteNotification(
      notificationId,
    );
  }




  @override
  Future<void> markAsRead(
    String notificationId,
  ) async {

    await remoteDatasource
        .markAsRead(
      notificationId,
    );
  }
}