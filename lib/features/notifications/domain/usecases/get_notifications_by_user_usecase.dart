import '../entities/notification.dart';

import '../repositories/notification_repository.dart';


class GetNotificationsByUserUsecase {

  final NotificationRepository
      repository;

  GetNotificationsByUserUsecase(
    this.repository,
  );


  Future<List<Notification>>
      call(
    String userId,
  ) async {

    return await repository
        .getNotificationsByUser(
      userId,
    );
  }
}