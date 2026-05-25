const alertResponseService =
    require('../services/alertResponseService');

const {
    validateCreateAlertResponse,
    validateUpdateAlertResponse,
} = require(
    '../validators/alertResponseValidator',
);




// CREATE ALERT RESPONSE

const createAlertResponse =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateAlertResponse(
                req.body,
            );



            const alertResponse =
                await alertResponseService
                    .createAlertResponse(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Alert response created successfully',
                data:
                    alertResponse,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL ALERT RESPONSES

const getAllAlertResponses =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const alertResponses =
                await alertResponseService
                    .getAllAlertResponses();



            res.status(200).json({
                success: true,
                data:
                    alertResponses,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALERT RESPONSE

const getAlertResponse =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const alertResponse =
                await alertResponseService
                    .getAlertResponse(
                        req.params
                            .responseId,
                    );



            res.status(200).json({
                success: true,
                data:
                    alertResponse,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE ALERT RESPONSE

const updateAlertResponse =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateAlertResponse(
                req.body,
            );



            const alertResponse =
                await alertResponseService
                    .updateAlertResponse(
                        req.params
                            .responseId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Alert response updated successfully',
                data:
                    alertResponse,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE ALERT RESPONSE

const deleteAlertResponse =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await alertResponseService
                .deleteAlertResponse(
                    req.params
                        .responseId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Alert response deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createAlertResponse,
    getAllAlertResponses,
    getAlertResponse,
    updateAlertResponse,
    deleteAlertResponse,
};