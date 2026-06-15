const AppError =
    require('../utils/appError');




// CREATE REWARD VALIDATOR

const validateCreateReward =
    (data) => {

        const {
            donorId,
            title,
            description,
            pointRequired,
            achievedAt,
        } = data;



        if (!donorId) {
            throw new AppError(
                'Donor ID is required',
                400,
            );
        }

        if (!title) {
            throw new AppError(
                'Title is required',
                400,
            );
        }

        if (!description) {
            throw new AppError(
                'Description is required',
                400,
            );
        }

        if (
            pointRequired ===
            undefined
        ) {
            throw new AppError(
                'Point required is required',
                400,
            );
        }

        if (!achievedAt) {
            throw new AppError(
                'Achieved date is required',
                400,
            );
        }



        // POINT REQUIRED VALIDATION

        if (
            typeof pointRequired !==
                'number' ||
            pointRequired < 0
        ) {
            throw new AppError(
                'Point required must be a positive number',
                400,
            );
        }



        // DATE VALIDATION

        if (
            isNaN(
                Date.parse(
                    achievedAt,
                ),
            )
        ) {
            throw new AppError(
                'Invalid achieved date',
                400,
            );
        }
    };




// UPDATE REWARD VALIDATOR

const validateUpdateReward =
    (data) => {

        const {
            pointRequired,
            achievedAt,
        } = data;



        if (
            pointRequired !==
                undefined &&
            (
                typeof pointRequired !==
                    'number' ||
                pointRequired < 0
            )
        ) {
            throw new AppError(
                'Point required must be a positive number',
                400,
            );
        }



        if (
            achievedAt &&
            isNaN(
                Date.parse(
                    achievedAt,
                ),
            )
        ) {
            throw new AppError(
                'Invalid achieved date',
                400,
            );
        }
    };


module.exports = {
    validateCreateReward,
    validateUpdateReward,
};