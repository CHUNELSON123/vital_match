const AppError = require('../utils/appError');

const validBloodGroups = [
    'aPositive',
    'aNegative',
    'bPositive',
    'bNegative',
    'abPositive',
    'abNegative',
    'oPositive',
    'oNegative',
];


// CREATE DONOR VALIDATOR

const validateCreateDonor = (data) => {

    const {
        userId,
        bloodGroup,
        weight,
        gpsLatitude,
        gpsLongitude,
        age,
        dateOfBirth,
    } = data;


    // REQUIRED FIELDS

    if (!userId) {
        throw new AppError(
            'User ID is required',
            400,
        );
    }

    if (!bloodGroup) {
        throw new AppError(
            'Blood group is required',
            400,
        );
    }

    if (weight === undefined) {
        throw new AppError(
            'Weight is required',
            400,
        );
    }

    if (gpsLatitude === undefined) {
        throw new AppError(
            'GPS latitude is required',
            400,
        );
    }

    if (gpsLongitude === undefined) {
        throw new AppError(
            'GPS longitude is required',
            400,
        );
    }

    if (age === undefined) {
        throw new AppError(
            'Age is required',
            400,
        );
    }

    if (!dateOfBirth) {
        throw new AppError(
            'Date of birth is required',
            400,
        );
    }


    // BLOOD GROUP VALIDATION

    if (!validBloodGroups.includes(bloodGroup)) {
        throw new AppError(
            'Invalid blood group',
            400,
        );
    }


    // AGE VALIDATION

    if (
        typeof age !== 'number' ||
        age < 18
    ) {
        throw new AppError(
            'Donor must be at least 18 years old',
            400,
        );
    }


    // WEIGHT VALIDATION

    if (
        typeof weight !== 'number' ||
        weight < 50
    ) {
        throw new AppError(
            'Donor must weigh at least 50kg',
            400,
        );
    }


    // GPS VALIDATION

    if (
        typeof gpsLatitude !== 'number'
    ) {
        throw new AppError(
            'GPS latitude must be a number',
            400,
        );
    }

    if (
        typeof gpsLongitude !== 'number'
    ) {
        throw new AppError(
            'GPS longitude must be a number',
            400,
        );
    }


    // DATE VALIDATION

    if (
        isNaN(Date.parse(dateOfBirth))
    ) {
        throw new AppError(
            'Invalid date of birth',
            400,
        );
    }
};


// UPDATE DONOR VALIDATOR

const validateUpdateDonor = (data) => {

    const {
        bloodGroup,
        weight,
        age,
        dateOfBirth,
    } = data;


    // BLOOD GROUP VALIDATION

    if (
        bloodGroup &&
        !validBloodGroups.includes(bloodGroup)
    ) {
        throw new AppError(
            'Invalid blood group',
            400,
        );
    }


    // AGE VALIDATION

    if (
        age !== undefined &&
        (
            typeof age !== 'number' ||
            age < 18
        )
    ) {
        throw new AppError(
            'Donor must be at least 18 years old',
            400,
        );
    }


    // WEIGHT VALIDATION

    if (
        weight !== undefined &&
        (
            typeof weight !== 'number' ||
            weight < 50
        )
    ) {
        throw new AppError(
            'Donor must weigh at least 50kg',
            400,
        );
    }


    // DATE VALIDATION

    if (
        dateOfBirth &&
        isNaN(Date.parse(dateOfBirth))
    ) {
        throw new AppError(
            'Invalid date of birth',
            400,
        );
    }
};


// UPDATE AVAILABILITY VALIDATOR

const validateAvailabilityUpdate = (data) => {

    const { isAvailable } = data;


    if (
        typeof isAvailable !== 'boolean'
    ) {
        throw new AppError(
            'isAvailable must be a boolean',
            400,
        );
    }
};


module.exports = {
    validateCreateDonor,
    validateUpdateDonor,
    validateAvailabilityUpdate,
};