const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRegex = /^(6)[0-9]{8}$/;
const AppError = require("../utils/appError");
 
const allowedRoles = [
    'donor',
    'hospitalAdministrator',
    'labTechnician',
    'bloodBankManager',
];

const validateCreateUser = (data) => {
    if(!data.fullName){
        throw new Error('Full name is required');
    }

    if(!data.email){
        throw new Error('Email is required');
    }

    if(!data.phoneNumber){
        throw new Error('Phone number is required');
    }

    if(!data.role){
        throw new Error('Role is required');
    }

    //Role validation
    if(!allowedRoles.includes(data.role)){
        throw new AppError('Invalid user role', 400);
    }

    //Email validation
    if (!emailRegex.test(data.email)) {
        throw new AppError("Invalid email format", 400);
    }

    //Phone number validation
    if (!phoneRegex.test(data.phoneNumber)) {
        throw new AppError("Invalid phone number", 400);
    }
};

const validateUpdateUser = (data) => {

    // VALIDATE ROLE ONLY IF PROVIDED
    if (
        data.role &&
        !allowedRoles.includes(data.role)
    ) {
        throw new AppError("Invalid user role", 400);
    }

    //Validate email only if provided
    if (
        data.email &&
        !emailRegex.test(data.email)
    ) {
        throw new AppError("Invalid email format", 400);
    }

    //Phone number validation if provided
    if (
        data.phoneNumber &&
        !phoneRegex.test(data.phoneNumber)
    ) {
        throw new AppError("Invalid phone number", 400);
    }
};

module.exports = {
    validateCreateUser,
    validateUpdateUser,
};