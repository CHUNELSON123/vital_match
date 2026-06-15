import '../entities/notification.dart';

import '../repositories/notification_repository.dart';


class GetAllNotificationsUsecase {

  final NotificationRepository
      repository;

  GetAllNotificationsUsecase(
    this.repository,
  );


  Future<List<Notification>>
      call() async {

    return await repository
        .getAllNotifications();
  }
}