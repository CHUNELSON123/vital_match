const AppError =
    require('../utils/appError');


const validNotificationTypes = [
    'emergencyAlert',
    'eligibilityReminder',
    'rewardNotification',
    'campaignAnnouncement',
    'inventoryWarning',
    'general',
];




// CREATE NOTIFICATION VALIDATOR

const validateCreateNotification =
    (data) => {

        const {
            userId,
            alertId,
            type,
            title,
            message,
            isRead,
        } = data;



        if (!userId) {
            throw new AppError(
                'User ID is required',
                400,
            );
        }

        if (!alertId) {
            throw new AppError(
                'Alert ID is required',
                400,
            );
        }

        if (!type) {
            throw new AppError(
                'Notification type is required',
                400,
            );
        }

        if (!title) {
            throw new AppError(
                'Title is required',
                400,
            );
        }

        if (!message) {
            throw new AppError(
                'Message is required',
                400,
            );
        }



        // TYPE VALIDATION

        if (
            !validNotificationTypes.includes(
                type,
            )
        ) {
            throw new AppError(
                'Invalid notification type',
                400,
            );
        }



        // IS READ VALIDATION

        if (
            isRead !== undefined &&
            typeof isRead !==
                'boolean'
        ) {
            throw new AppError(
                'isRead must be a boolean',
                400,
            );
        }
    };




// UPDATE NOTIFICATION VALIDATOR

const validateUpdateNotification =
    (data) => {

        const {
            type,
            isRead,
        } = data;



        if (
            type &&
            !validNotificationTypes.includes(
                type,
            )
        ) {
            throw new AppError(
                'Invalid notification type',
                400,
            );
        }



        if (
            isRead !== undefined &&
            typeof isRead !==
                'boolean'
        ) {
            throw new AppError(
                'isRead must be a boolean',
                400,
            );
        }
    };


module.exports = {
    validateCreateNotification,
    validateUpdateNotification,
};