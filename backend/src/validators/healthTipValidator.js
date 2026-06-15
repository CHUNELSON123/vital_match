const AppError =
    require('../utils/appError');




// CREATE HEALTH TIP VALIDATOR

const validateCreateHealthTip =
    (data) => {

        const {
            title,
            content,
            category,
        } = data;



        if (!title) {
            throw new AppError(
                'Title is required',
                400,
            );
        }

        if (!content) {
            throw new AppError(
                'Content is required',
                400,
            );
        }

        if (!category) {
            throw new AppError(
                'Category is required',
                400,
            );
        }
    };




// UPDATE HEALTH TIP VALIDATOR

const validateUpdateHealthTip =
    (data) => {

        const {
            title,
            content,
            category,
        } = data;



        if (
            title !== undefined &&
            typeof title !== 'string'
        ) {
            throw new AppError(
                'Title must be a string',
                400,
            );
        }

        if (
            content !== undefined &&
            typeof content !== 'string'
        ) {
            throw new AppError(
                'Content must be a string',
                400,
            );
        }

        if (
            category !== undefined &&
            typeof category !== 'string'
        ) {
            throw new AppError(
                'Category must be a string',
                400,
            );
        }
    };


module.exports = {
    validateCreateHealthTip,
    validateUpdateHealthTip,
};