import '../repositories/notification_repository.dart';


class MarkNotificationAsReadUsecase {

  final NotificationRepository
      repository;

  MarkNotificationAsReadUsecase(
    this.repository,
  );


  Future<void> call(
    String notificationId,
  ) async {

    await repository
        .markAsRead(
      notificationId,
    );
  }
}