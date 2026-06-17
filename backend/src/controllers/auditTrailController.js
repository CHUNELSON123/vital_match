const auditTrailService =
    require(
        '../services/auditTrailService',
    );

const {
    validateCreateAuditTrail,
    validateUpdateAuditTrail,
} = require(
    '../validators/auditTrailValidator',
);




// CREATE AUDIT TRAIL

const createAuditTrail =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateAuditTrail(
                req.body,
            );



            const auditTrail =
                await auditTrailService
                    .createAuditTrail(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Audit trail created successfully',
                data: auditTrail,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL AUDIT TRAILS

const getAllAuditTrails =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const auditTrails =
                await auditTrailService
                    .getAllAuditTrails();



            res.status(200).json({
                success: true,
                data: auditTrails,
            });

        } catch (error) {
            next(error);
        }
    };




// GET AUDIT TRAIL

const getAuditTrail =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const auditTrail =
                await auditTrailService
                    .getAuditTrail(
                        req.params
                            .auditId,
                    );



            res.status(200).json({
                success: true,
                data: auditTrail,
            });

        } catch (error) {
            next(error);
        }
    };




// GET AUDIT TRAILS BY USER

const getAuditTrailsByUser =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const auditTrails =
                await auditTrailService
                    .getAuditTrailsByUser(
                        req.params
                            .userId,
                    );



            res.status(200).json({
                success: true,
                data: auditTrails,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE AUDIT TRAIL

const updateAuditTrail =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateAuditTrail(
                req.body,
            );



            const auditTrail =
                await auditTrailService
                    .updateAuditTrail(
                        req.params
                            .auditId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Audit trail updated successfully',
                data: auditTrail,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE AUDIT TRAIL

const deleteAuditTrail =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await auditTrailService
                .deleteAuditTrail(
                    req.params
                        .auditId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Audit trail deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };

const getAuditTrailsByHospital =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const auditTrails =
                await auditTrailService
                    .getAuditTrailsByHospital(
                        req.params
                            .hospitalId,
                    );

            res.status(200).json({
                success: true,
                data: auditTrails,
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createAuditTrail,
    getAllAuditTrails,
    getAuditTrail,
    getAuditTrailsByUser,
    updateAuditTrail,
    deleteAuditTrail,
    getAuditTrailsByHospital,
};