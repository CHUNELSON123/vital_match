const emergencyAlertService =
    require('../services/emergencyAlertService');

const {
    validateCreateEmergencyAlert,
    validateUpdateEmergencyAlert,
} = require(
    '../validators/emergencyAlertValidator',
);




// CREATE EMERGENCY ALERT

const createEmergencyAlert =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateEmergencyAlert(
                req.body,
            );



            const emergencyAlert =
                await emergencyAlertService
                    .createEmergencyAlert(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Emergency alert created successfully',
                data:
                    emergencyAlert,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL EMERGENCY ALERTS

const getAllEmergencyAlerts =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const emergencyAlerts =
                await emergencyAlertService
                    .getAllEmergencyAlerts();



            res.status(200).json({
                success: true,
                data:
                    emergencyAlerts,
            });

        } catch (error) {
            next(error);
        }
    };




// GET EMERGENCY ALERT BY ID

const getEmergencyAlert =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const emergencyAlert =
                await emergencyAlertService
                    .getEmergencyAlert(
                        req.params.alertId,
                    );



            res.status(200).json({
                success: true,
                data:
                    emergencyAlert,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE EMERGENCY ALERT

const updateEmergencyAlert =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateEmergencyAlert(
                req.body,
            );



            const emergencyAlert =
                await emergencyAlertService
                    .updateEmergencyAlert(
                        req.params.alertId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Emergency alert updated successfully',
                data:
                    emergencyAlert,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE EMERGENCY ALERT

const deleteEmergencyAlert =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await emergencyAlertService
                .deleteEmergencyAlert(
                    req.params.alertId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Emergency alert deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createEmergencyAlert,
    getAllEmergencyAlerts,
    getEmergencyAlert,
    updateEmergencyAlert,
    deleteEmergencyAlert,
};