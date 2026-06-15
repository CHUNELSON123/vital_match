const healthTipService =
    require(
        '../services/healthTipService',
    );

const {
    validateCreateHealthTip,
    validateUpdateHealthTip,
} = require(
    '../validators/healthTipValidator',
);




// CREATE HEALTH TIP

const createHealthTip =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateHealthTip(
                req.body,
            );



            const healthTip =
                await healthTipService
                    .createHealthTip(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Health tip created successfully',
                data: healthTip,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL HEALTH TIPS

const getAllHealthTips =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const healthTips =
                await healthTipService
                    .getAllHealthTips();



            res.status(200).json({
                success: true,
                data: healthTips,
            });

        } catch (error) {
            next(error);
        }
    };




// GET HEALTH TIP

const getHealthTip =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const healthTip =
                await healthTipService
                    .getHealthTip(
                        req.params.tipId,
                    );



            res.status(200).json({
                success: true,
                data: healthTip,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE HEALTH TIP

const updateHealthTip =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateHealthTip(
                req.body,
            );



            const healthTip =
                await healthTipService
                    .updateHealthTip(
                        req.params.tipId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Health tip updated successfully',
                data: healthTip,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE HEALTH TIP

const deleteHealthTip =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await healthTipService
                .deleteHealthTip(
                    req.params.tipId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Health tip deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createHealthTip,
    getAllHealthTips,
    getHealthTip,
    updateHealthTip,
    deleteHealthTip,
};