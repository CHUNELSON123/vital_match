import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification_model.dart';

import 'notification_remote_datasource.dart';


class NotificationRemoteDatasourceImpl
    implements
        NotificationRemoteDatasource {

  final FirebaseFirestore firestore;

  NotificationRemoteDatasourceImpl(
    this.firestore,
  );


  final String notificationCollection =
      'notifications';




  @override
  Future<void> createNotification(
    NotificationModel notification,
  ) async {

    await firestore
        .collection(
          notificationCollection,
        )
        .doc(
          notification.notificationId,
        )
        .set(
          notification.toMap(),
        );
  }




  @override
  Future<NotificationModel>
      getNotification(
    String notificationId,
  ) async {

    final doc =
        await firestore
            .collection(
              notificationCollection,
            )
            .doc(
              notificationId,
            )
            .get();

    return NotificationModel
        .fromFirestore(
      doc,
    );
  }




  @override
  Future<List<NotificationModel>>
      getAllNotifications() async {

    final snapshot =
        await firestore
            .collection(
              notificationCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              NotificationModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }




  @override
  Future<List<NotificationModel>>
      getNotificationsByUser(
    String userId,
  ) async {

    final snapshot =
        await firestore
            .collection(
              notificationCollection,
            )
            .where(
              'userId',
              isEqualTo: userId,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              NotificationModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }




  @override
  Future<void> updateNotification(
    NotificationModel notification,
  ) async {

    await firestore
        .collection(
          notificationCollection,
        )
        .doc(
          notification.notificationId,
        )
        .update(
          notification.toMap(),
        );
  }




  @override
  Future<void> deleteNotification(
    String notificationId,
  ) async {

    await firestore
        .collection(
          notificationCollection,
        )
        .doc(
          notificationId,
        )
        .delete();
  }




  @override
  Future<void> markAsRead(
    String notificationId,
  ) async {

    await firestore
        .collection(
          notificationCollection,
        )
        .doc(
          notificationId,
        )
        .update({
      'isRead': true,
    });
  }
}