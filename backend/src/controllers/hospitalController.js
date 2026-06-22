const hospitalService = require('../services/hospitalService');


// CREATE HOSPITAL

const createHospital = async (
    req,
    res,
    next,
) => {

    console.log('CREATE HOSPITAL CONTROLLER HIT');
    console.log('USER UID:', req.user.uid);

    try {

        const hospital =
            await hospitalService.createHospital(
                req.body,
                req.user.uid,
            );

        res.status(201).json({
            success: true,
            message: 'Hospital created successfully',
            data: hospital,
        });

    } catch (error) {
        next(error);
    }
};


// GET HOSPITAL

const getHospital = async (
    req,
    res,
    next,
) => {

    try {

        const hospital =
            await hospitalService.getHospital(
                req.params.hospitalId,
            );

        res.status(200).json({
            success: true,
            data: hospital,
        });

    } catch (error) {
        next(error);
    }
};


// UPDATE HOSPITAL

const updateHospital = async (
    req,
    res,
    next,
) => {

    try {

        const updatedHospital =
            await hospitalService.updateHospital(
                req.params.hospitalId,
                req.body,
            );

        res.status(200).json({
            success: true,
            message: 'Hospital updated successfully',
            data: updatedHospital,
        });

    } catch (error) {
        next(error);
    }
};


// DELETE HOSPITAL

const deleteHospital = async (
    req,
    res,
    next,
) => {

    try {

        await hospitalService.deleteHospital(
            req.params.hospitalId,
        );

        res.status(200).json({
            success: true,
            message: 'Hospital deleted successfully',
        });

    } catch (error) {
        next(error);
    }
};

const getHospitalByOwnerId =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const hospital =
                await hospitalService
                    .getHospitalByOwnerId(
                        req.params.ownerId,
                    );

            res.status(200).json({
                success: true,
                data: hospital,
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createHospital,
    getHospital,
    updateHospital,
    deleteHospital,
    getHospitalByOwnerId,
};