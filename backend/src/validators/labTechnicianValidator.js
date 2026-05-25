const AppError =
    require('../utils/appError');




// CREATE LAB TECHNICIAN VALIDATOR

const validateCreateLabTechnician = (
    data,
) => {

    if (!data.userId) {
        throw new AppError(
            'User ID is required',
            400,
        );
    }

    if (!data.hospitalId) {
        throw new AppError(
            'Hospital ID is required',
            400,
        );
    }

    if (!data.employeeId) {
        throw new AppError(
            'Employee ID is required',
            400,
        );
    }

    if (!data.department) {
        throw new AppError(
            'Department is required',
            400,
        );
    }
};




// UPDATE LAB TECHNICIAN VALIDATOR

const validateUpdateLabTechnician = (
    data,
) => {

    if (
        data.employeeId !==
            undefined &&
        data.employeeId.trim() === ''
    ) {
        throw new AppError(
            'Employee ID cannot be empty',
            400,
        );
    }

    if (
        data.department !==
            undefined &&
        data.department.trim() === ''
    ) {
        throw new AppError(
            'Department cannot be empty',
            400,
        );
    }
};


module.exports = {
    validateCreateLabTechnician,
    validateUpdateLabTechnician,
};