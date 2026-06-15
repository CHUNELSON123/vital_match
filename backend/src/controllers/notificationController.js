const notificationService =
    require(
        '../services/notificationService',
    );

const {
    validateCreateNotification,
    validateUpdateNotification,
} = require(
    '../validators/notificationValidator',
);




// CREATE NOTIFICATION

const createNotification =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateNotification(
                req.body,
            );



            const notification =
                await notificationService
                    .createNotification(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Notification created successfully',
                data:
                    notification,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL NOTIFICATIONS

const getAllNotifications =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const notifications =
                await notificationService
                    .getAllNotifications();



            res.status(200).json({
                success: true,
                data:
                    notifications,
            });

        } catch (error) {
            next(error);
        }
    };




// GET NOTIFICATION

const getNotification =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const notification =
                await notificationService
                    .getNotification(
                        req.params
                            .notificationId,
                    );



            res.status(200).json({
                success: true,
                data:
                    notification,
            });

        } catch (error) {
            next(error);
        }
    };




// GET NOTIFICATIONS BY USER

const getNotificationsByUser =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const notifications =
                await notificationService
                    .getNotificationsByUser(
                        req.params.userId,
                    );



            res.status(200).json({
                success: true,
                data:
                    notifications,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE NOTIFICATION

const updateNotification =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateNotification(
                req.body,
            );



            const notification =
                await notificationService
                    .updateNotification(
                        req.params
                            .notificationId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Notification updated successfully',
                data:
                    notification,
            });

        } catch (error) {
            next(error);
        }
    };




// MARK NOTIFICATION AS READ

const markNotificationAsRead =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const notification =
                await notificationService
                    .markNotificationAsRead(
                        req.params
                            .notificationId,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Notification marked as read',
                data:
                    notification,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE NOTIFICATION

const deleteNotification =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await notificationService
                .deleteNotification(
                    req.params
                        .notificationId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Notification deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createNotification,
    getAllNotifications,
    getNotification,
    getNotificationsByUser,
    updateNotification,
    markNotificationAsRead,
    deleteNotification,
};