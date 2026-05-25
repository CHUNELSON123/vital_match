const AppError =
    require('../utils/appError');




// VALIDATE CREATE

const validateCreateBloodBankManager =
    (data) => {

        const {
            userId,
            bloodBankId,
            staffId,
            accessLevel,
        } = data;



        if (!userId) {
            throw new AppError(
                'userId is required',
                400,
            );
        }



        if (!bloodBankId) {
            throw new AppError(
                'bloodBankId is required',
                400,
            );
        }



        if (!staffId) {
            throw new AppError(
                'staffId is required',
                400,
            );
        }



        if (!accessLevel) {
            throw new AppError(
                'accessLevel is required',
                400,
            );
        }
    };




// VALIDATE UPDATE

const validateUpdateBloodBankManager =
    (data) => {

        const {
            accessLevel,
        } = data;



        if (
            accessLevel !== undefined &&
            typeof accessLevel !==
                'string'
        ) {

            throw new AppError(
                'accessLevel must be a string',
                400,
            );
        }
    };



module.exports = {
    validateCreateBloodBankManager,
    validateUpdateBloodBankManager,
};