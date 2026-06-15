const AppError =
    require('../utils/appError');




// VALIDATE CREATE

const validateCreateHospitalAdmin =
    (data) => {

        const {
            userId,
            hospitalId,
            adminLevel,
        } = data;



        if (
            hospitalId !== undefined &&
            hospitalId !== null &&
            typeof hospitalId !== 'string'
        ) {
            throw new AppError(
                'hospitalId must be a string',
                400,
            );
        }



        if (!hospitalId) {
            throw new AppError(
                'hospitalId is required',
                400,
            );
        }



        if (!adminLevel) {
            throw new AppError(
                'adminLevel is required',
                400,
            );
        }
    };




// VALIDATE UPDATE

const validateUpdateHospitalAdmin =
    (data) => {

        const {
            adminLevel,
        } = data;



        if (
            adminLevel !== undefined &&
            typeof adminLevel !==
                'string'
        ) {
            throw new AppError(
                'adminLevel must be a string',
                400,
            );
        }
    };



module.exports = {
    validateCreateHospitalAdmin,
    validateUpdateHospitalAdmin,
};