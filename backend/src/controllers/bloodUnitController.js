const bloodUnitService =
    require('../services/bloodUnitService');

const {
    validateCreateBloodUnit,
    validateUpdateBloodUnit,
} = require('../validators/bloodUnitValidator');



// CREATE BLOOD UNIT

const createBloodUnit = async (
    req,
    res,
    next,
) => {

    try {

        validateCreateBloodUnit(
            req.body,
        );

        const bloodUnit =
            await bloodUnitService
                .createBloodUnit(
                    req.body,
                );

        res.status(201).json({
            success: true,
            message:
                'Blood unit created successfully',
            data: bloodUnit,
        });

    } catch (error) {
        next(error);
    }
};



// GET BLOOD UNIT

const getBloodUnit = async (
    req,
    res,
    next,
) => {

    try {

        const bloodUnit =
            await bloodUnitService
                .getBloodUnit(
                    req.params
                        .bloodUnitId,
                );

        res.status(200).json({
            success: true,
            data: bloodUnit,
        });

    } catch (error) {
        next(error);
    }
};



// UPDATE BLOOD UNIT

const updateBloodUnit = async (
    req,
    res,
    next,
) => {

    try {

        validateUpdateBloodUnit(
            req.body,
        );

        const updatedBloodUnit =
            await bloodUnitService
                .updateBloodUnit(
                    req.params
                        .bloodUnitId,
                    req.body,
                );

        res.status(200).json({
            success: true,
            message:
                'Blood unit updated successfully',
            data: updatedBloodUnit,
        });

    } catch (error) {
        next(error);
    }
};



// DELETE BLOOD UNIT

const deleteBloodUnit = async (
    req,
    res,
    next,
) => {

    try {

        await bloodUnitService
            .deleteBloodUnit(
                req.params
                    .bloodUnitId,
            );

        res.status(200).json({
            success: true,
            message:
                'Blood unit deleted successfully',
        });

    } catch (error) {
        next(error);
    }
};

// GET BLOOD UNITS BY HOSPITAL

const getBloodUnitsByHospital =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const bloodUnits =
                await bloodUnitService
                    .getBloodUnitsByHospital(
                        req.params.hospitalId,
                    );

            res.status(200).json({
                success: true,
                data: bloodUnits,
            });

        } catch (error) {
            next(error);
        }
    };

const getAllBloodUnits =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const bloodUnits =
                await bloodUnitService
                    .getAllBloodUnits();

            res.status(200).json({
                success: true,
                data: bloodUnits,
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createBloodUnit,
    getBloodUnit,
    updateBloodUnit,
    deleteBloodUnit,
    getBloodUnitsByHospital,
    getAllBloodUnits,
};