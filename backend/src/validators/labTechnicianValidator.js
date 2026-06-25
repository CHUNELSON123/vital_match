const AppError =
    require('../utils/appError');

const emailRegex =
    /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const phoneRegex =
    /^(\+237\s?)?6[0-9]{8}$/;


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

    if (data.fullName.trim().length < 3) {
        throw new AppError(
            'Full name must be at least 3 characters',
            400,
        );
    }

    if (!data.email) {
        throw new AppError(
            'Email is required',
            400,
        );
    }

    if (!emailRegex.test(data.email.trim())) {
        throw new AppError(
            'Invalid email format',
            400,
        );
    }

    if (!data.phoneNumber) {
        throw new AppError(
            'Phone number is required',
            400,
        );
    }

    if (!phoneRegex.test(data.phoneNumber.trim())) {
        throw new AppError(
            'Invalid phone number',
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
            (
                data.email.trim() === '' ||
                !emailRegex.test(data.email.trim())
            )
        ) {
            throw new AppError(
                'Invalid email format',
                400,
            );
        }

        if (
            data.phoneNumber != null &&
            (
                data.phoneNumber.trim() === '' ||
                !phoneRegex.test(data.phoneNumber.trim())
            )
        ) {
            throw new AppError(
                'Invalid phone number',
                400,
            );
        }
    };
module.exports = {
    validateCreateLabTechnician,
    validateUpdateLabTechnician,
};
