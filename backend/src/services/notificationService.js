const { db } =
    require('../config/firebase');


const notificationCollection =
    db.collection(
        'notifications',
    );

const userCollection =
    db.collection(
        'users',
    );

const emergencyAlertCollection =
    db.collection(
        'emergency_alerts',
    );




// CREATE NOTIFICATION

const createNotification =
    async (
        notificationData,
    ) => {

        // VALIDATE USER

        const userDoc =
            await userCollection
                .doc(
                    notificationData
                        .userId,
                )
                .get();

        if (!userDoc.exists) {
            throw new Error(
                'User not found',
            );
        }



        // VALIDATE ALERT

        if (notificationData.alertId) {
            const alertDoc =
                await emergencyAlertCollection
                    .doc(
                        notificationData
                            .alertId,
                    )
                    .get();

            if (
                !alertDoc.exists &&
                notificationData.type ===
                    'emergencyAlert'
            ) {
                throw new Error(
                    'Emergency alert not found',
                );
            }
        }



        // CREATE NOTIFICATION

        const notificationRef =
            notificationCollection
                .doc();

        const notification = {
            notificationId:
                notificationRef.id,

            ...notificationData,

            alertId:
                notificationData.alertId ??
                null,

            isRead:
                notificationData
                    .isRead ??
                false,

            sentAt:
                new Date(),
        };

        await notificationRef.set(
            notification,
        );

        await sendPushNotification(
            notification,
        );

        return notification;
    };

const sendPushNotification =
    async (notification) => {
        const userDoc =
            await userCollection
                .doc(notification.userId)
                .get();

        if (!userDoc.exists) {
            return;
        }

        const user = userDoc.data();
        const token =
            user.fcmToken ||
            user.deviceToken;

        if (!token) {
            return;
        }

        try {
            await require('../config/firebase')
                .admin
                .messaging()
                .send({
                    token,
                    notification: {
                        title:
                            notification.title,
                        body:
                            notification.message,
                    },
                    data: {
                        notificationId:
                            notification.notificationId,
                        type:
                            notification.type,
                        alertId:
                            notification.alertId || '',
                        deepLink:
                            notification.deepLink || '',
                        actions:
                            JSON.stringify(
                                notification.actions || [],
                            ),
                    },
                });
        } catch (error) {
            console.error(
                'Push notification failed:',
                error.message,
            );
        }
    };




// GET NOTIFICATION

const getNotification =
    async (
        notificationId,
    ) => {

        const doc =
            await notificationCollection
                .doc(
                    notificationId,
                )
                .get();

        if (!doc.exists) {
            throw new Error(
                'Notification not found',
            );
        }

        return doc.data();
    };




// GET ALL NOTIFICATIONS

const getAllNotifications =
    async () => {

        const snapshot =
            await notificationCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// GET NOTIFICATIONS BY USER

const getNotificationsByUser =
    async (userId) => {

        const snapshot =
            await notificationCollection
                .where(
                    'userId',
                    '==',
                    userId,
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE NOTIFICATION

const updateNotification =
    async (
        notificationId,
        updateData,
    ) => {

        const docRef =
            notificationCollection
                .doc(
                    notificationId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Notification not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// MARK NOTIFICATION AS READ

const markNotificationAsRead =
    async (
        notificationId,
    ) => {

        const docRef =
            notificationCollection
                .doc(
                    notificationId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Notification not found',
            );
        }

        await docRef.update({
            isRead: true,
        });

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE NOTIFICATION

const deleteNotification =
    async (
        notificationId,
    ) => {

        const docRef =
            notificationCollection
                .doc(
                    notificationId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Notification not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createNotification,
    getNotification,
    getAllNotifications,
    getNotificationsByUser,
    updateNotification,
    markNotificationAsRead,
    deleteNotification,
};
