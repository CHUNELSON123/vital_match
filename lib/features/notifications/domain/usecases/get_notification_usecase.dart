import '../entities/notification.dart';

import '../repositories/notification_repository.dart';


class GetNotificationUsecase {

  final NotificationRepository
      repository;

  GetNotificationUsecase(
    this.repository,
  );


  Future<Notification> call(
    String notificationId,
  ) async {

    return await repository
        .getNotification(
      notificationId,
    );
  }
}