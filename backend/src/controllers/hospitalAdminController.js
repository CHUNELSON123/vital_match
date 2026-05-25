const hospitalAdminService =
    require('../services/hospitalAdminService');

const {
    validateCreateHospitalAdmin,
    validateUpdateHospitalAdmin,
} = require('../validators/hospitalAdminValidator');




// CREATE HOSPITAL ADMIN

const createHospitalAdmin =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateHospitalAdmin(
                req.body,
            );

            const hospitalAdmin =
                await hospitalAdminService
                    .createHospitalAdmin(
                        req.body,
                    );

            res.status(201).json({
                success: true,
                message:
                    'Hospital admin created successfully',
                data: hospitalAdmin,
            });

        } catch (error) {
            next(error);
        }
    };




// GET HOSPITAL ADMIN

const getHospitalAdmin =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const hospitalAdmin =
                await hospitalAdminService
                    .getHospitalAdmin(
                        req.params
                            .adminId,
                    );

            res.status(200).json({
                success: true,
                data: hospitalAdmin,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL HOSPITAL ADMINS

const getAllHospitalAdmins =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const hospitalAdmins =
                await hospitalAdminService
                    .getAllHospitalAdmins();

            res.status(200).json({
                success: true,
                data: hospitalAdmins,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE HOSPITAL ADMIN

const updateHospitalAdmin =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateHospitalAdmin(
                req.body,
            );

            const updatedHospitalAdmin =
                await hospitalAdminService
                    .updateHospitalAdmin(
                        req.params
                            .adminId,
                        req.body,
                    );

            res.status(200).json({
                success: true,
                message:
                    'Hospital admin updated successfully',
                data:
                    updatedHospitalAdmin,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE HOSPITAL ADMIN

const deleteHospitalAdmin =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await hospitalAdminService
                .deleteHospitalAdmin(
                    req.params
                        .adminId,
                );

            res.status(200).json({
                success: true,
                message:
                    'Hospital admin deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createHospitalAdmin,
    getHospitalAdmin,
    getAllHospitalAdmins,
    updateHospitalAdmin,
    deleteHospitalAdmin,
};