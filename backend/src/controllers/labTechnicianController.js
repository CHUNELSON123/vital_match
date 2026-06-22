const labTechnicianService =
    require('../services/labTechnicianService');

const {
    validateCreateLabTechnician,
    validateUpdateLabTechnician,
} = require('../validators/labTechnicianValidator');




// CREATE LAB TECHNICIAN
const createLabTechnician =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateLabTechnician(
                req.body,
            );

            const technician =
                await labTechnicianService
                    .createLabTechnician(
                        req.body,
                    );

            res.status(201).json({
                success: true,
                message:
                    'Lab technician created successfully',
                data: technician,
            });

        } catch (error) {
            next(error);
        }
    };




// GET LAB TECHNICIAN
const getLabTechnician =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const technician =
                await labTechnicianService
                    .getLabTechnician(
                        req.params
                            .technicianId,
                    );

            res.status(200).json({
                success: true,
                data: technician,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL LAB TECHNICIANS

const getAllLabTechnicians =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const technicians =
                await labTechnicianService
                    .getAllLabTechnicians();

            res.status(200).json({
                success: true,
                data: technicians,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE LAB TECHNICIAN
const updateLabTechnician =
    async (
        req,
        res,
        next,
    ) => {

        try {

            console.log(
                'TECHNICIAN ID:',
                req.params.technicianId,
            );

            console.log(
                'BODY:',
                req.body,
            );

            validateUpdateLabTechnician(
                req.body,
            );

            const updatedTechnician =
                await labTechnicianService
                    .updateLabTechnician(
                        req.params
                            .technicianId,
                        req.body,
                    );

            res.status(200).json({
                success: true,
                message:
                    'Lab technician updated successfully',
                data:
                    updatedTechnician,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE LAB TECHNICIAN

const deleteLabTechnician =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await labTechnicianService
                .deleteLabTechnician(
                    req.params
                        .technicianId,
                );

            res.status(200).json({
                success: true,
                message:
                    'Lab technician deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };

const getTechniciansByHospital =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const technicians =
                await labTechnicianService
                    .getTechniciansByHospital(
                        req.params.hospitalId,
                    );

            res.status(200).json({
                success: true,
                data: technicians,
            });

        } catch (error) {
            next(error);
        }
    };


    const getLabTechnicianByUserId =
    async (req, res, next) => {
    try {

        const technician =
            await labTechnicianService
                .getLabTechnicianByUserId(
                    req.params.userId,
                );

        if (!technician) {
            return res.status(404).json({
                success: false,
                message:
                    'Lab technician not found',
            });
        }

        res.status(200).json({
            success: true,
            data: technician,
        });

    } catch (error) {
        next(error);
    }
};


module.exports = {
    createLabTechnician,
    getLabTechnician,
    getAllLabTechnicians,
    updateLabTechnician,
    deleteLabTechnician,
    getTechniciansByHospital,
    getLabTechnicianByUserId,
};