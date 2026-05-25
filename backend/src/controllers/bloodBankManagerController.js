const bloodBankManagerService =
    require(
        '../services/bloodBankManagerService',
    );

const {
    validateCreateBloodBankManager,
    validateUpdateBloodBankManager,
} = require(
    '../validators/bloodBankManagerValidator',
);




// CREATE BLOOD BANK MANAGER

const createBloodBankManager =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateBloodBankManager(
                req.body,
            );

            const manager =
                await bloodBankManagerService
                    .createBloodBankManager(
                        req.body,
                    );

            res.status(201).json({
                success: true,
                message:
                    'Blood bank manager created successfully',
                data: manager,
            });

        } catch (error) {
            next(error);
        }
    };




// GET BLOOD BANK MANAGER

const getBloodBankManager =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const manager =
                await bloodBankManagerService
                    .getBloodBankManager(
                        req.params
                            .managerId,
                    );

            res.status(200).json({
                success: true,
                data: manager,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL BLOOD BANK MANAGERS

const getAllBloodBankManagers =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const managers =
                await bloodBankManagerService
                    .getAllBloodBankManagers();

            res.status(200).json({
                success: true,
                data: managers,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE BLOOD BANK MANAGER

const updateBloodBankManager =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateBloodBankManager(
                req.body,
            );

            const updatedManager =
                await bloodBankManagerService
                    .updateBloodBankManager(
                        req.params
                            .managerId,
                        req.body,
                    );

            res.status(200).json({
                success: true,
                message:
                    'Blood bank manager updated successfully',
                data:
                    updatedManager,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE BLOOD BANK MANAGER

const deleteBloodBankManager =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await bloodBankManagerService
                .deleteBloodBankManager(
                    req.params
                        .managerId,
                );

            res.status(200).json({
                success: true,
                message:
                    'Blood bank manager deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };



module.exports = {
    createBloodBankManager,
    getBloodBankManager,
    getAllBloodBankManagers,
    updateBloodBankManager,
    deleteBloodBankManager,
};