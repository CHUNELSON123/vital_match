import '../entities/notification.dart';

import '../repositories/notification_repository.dart';


class UpdateNotificationUsecase {

  final NotificationRepository
      repository;

  UpdateNotificationUsecase(
    this.repository,
  );


  Future<void> call(
    Notification notification,
  ) async {

    await repository
        .updateNotification(
      notification,
    );
  }
}