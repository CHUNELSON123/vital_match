const AppError =
    require('../utils/appError');




// CREATE LAB TECHNICIAN VALIDATOR
const validateCreateLabTechnician = (
    data,
) => {

    if (!data.fullName) {
        throw new AppError(
            'Full name is required',
            400,
        );
    }

    if (!data.email) {
        throw new AppError(
            'Email is required',
            400,
        );
    }

    if (!data.phoneNumber) {
        throw new AppError(
            'Phone number is required',
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
const validateUpdateLabTechnician =
    (data) => {

        if (
            data.employeeId != null &&
            data.employeeId.trim() === ''
        ) {
            throw new AppError(
                'Employee ID cannot be empty',
                400,
            );
        }

        if (
            data.department != null &&
            data.department.trim() === ''
        ) {
            throw new AppError(
                'Department cannot be empty',
                400,
            );
        }

        if (
            data.fullName != null &&
            data.fullName.trim() === ''
        ) {
            throw new AppError(
                'Full Name cannot be empty',
                400,
            );
        }

        if (
            data.email != null &&
            data.email.trim() === ''
        ) {
            throw new AppError(
                'Email cannot be empty',
                400,
            );
        }

        if (
            data.phoneNumber != null &&
            data.phoneNumber.trim() === ''
        ) {
            throw new AppError(
                'Phone Number cannot be empty',
                400,
            );
        }
    };
module.exports = {
    validateCreateLabTechnician,
    validateUpdateLabTechnician,
};