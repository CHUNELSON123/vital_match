const express =
    require('express');

const notificationController =
    require(
        '../controllers/notificationController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);

const router =
    express.Router();




// CREATE NOTIFICATION

router.post(
    '/',
    verifyToken,
    notificationController
        .createNotification,
);




// GET ALL NOTIFICATIONS

router.get(
    '/',
    verifyToken,
    notificationController
        .getAllNotifications,
);




// GET NOTIFICATIONS BY USER

router.get(
    '/user/:userId',
    verifyToken,
    notificationController
        .getNotificationsByUser,
);




// GET NOTIFICATION

router.get(
    '/:notificationId',
    verifyToken,
    notificationController
        .getNotification,
);




// UPDATE NOTIFICATION

router.put(
    '/:notificationId',
    verifyToken,
    notificationController
        .updateNotification,
);




// MARK NOTIFICATION AS READ

router.patch(
    '/:notificationId/read',
    verifyToken,
    notificationController
        .markNotificationAsRead,
);




// DELETE NOTIFICATION

router.delete(
    '/:notificationId',
    verifyToken,
    notificationController
        .deleteNotification,
);


module.exports = router;