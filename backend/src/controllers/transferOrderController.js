const transferOrderService =
    require('../services/transferOrderService');

const {
    validateCreateTransferOrder,
    validateUpdateTransferOrder,
} = require(
    '../validators/transferOrderValidator',
);




// CREATE TRANSFER ORDER

const createTransferOrder =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateTransferOrder(
                req.body,
            );



            const transferOrder =
                await transferOrderService
                    .createTransferOrder(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Transfer order created successfully',
                data:
                    transferOrder,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL TRANSFER ORDERS

const getAllTransferOrders =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const transferOrders =
                await transferOrderService
                    .getAllTransferOrders();



            res.status(200).json({
                success: true,
                data:
                    transferOrders,
            });

        } catch (error) {
            next(error);
        }
    };




// GET TRANSFER ORDER

const getTransferOrder =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const transferOrder =
                await transferOrderService
                    .getTransferOrder(
                        req.params.orderId,
                    );



            res.status(200).json({
                success: true,
                data:
                    transferOrder,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE TRANSFER ORDER

const updateTransferOrder =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateTransferOrder(
                req.body,
            );



            const transferOrder =
                await transferOrderService
                    .updateTransferOrder(
                        req.params.orderId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Transfer order updated successfully',
                data:
                    transferOrder,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE TRANSFER ORDER

const deleteTransferOrder =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await transferOrderService
                .deleteTransferOrder(
                    req.params.orderId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Transfer order deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createTransferOrder,
    getAllTransferOrders,
    getTransferOrder,
    updateTransferOrder,
    deleteTransferOrder,
};