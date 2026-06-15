import '../entities/notification.dart';

import '../repositories/notification_repository.dart';


class CreateNotificationUsecase {

  final NotificationRepository
      repository;

  CreateNotificationUsecase(
    this.repository,
  );


  Future<void> call(
    Notification notification,
  ) async {

    await repository
        .createNotification(
      notification,
    );
  }
}