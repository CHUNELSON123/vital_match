const AppError =
    require('../utils/appError');


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


const validAlertStatuses = [
    'pending',
    'active',
    'fulfilled',
    'cancelled',
    'expired',
];




// CREATE EMERGENCY ALERT VALIDATOR

const validateCreateEmergencyAlert = (
    data,
) => {

    if (!data.hospitalId) {
        throw new AppError(
            'Hospital ID is required',
            400,
        );
    }

    if (!data.technicianId) {
        throw new AppError(
            'Technician ID is required',
            400,
        );
    }

    if (!data.bloodGroup) {
        throw new AppError(
            'Blood group is required',
            400,
        );
    }

    if (
        data.unitsNeeded ===
        undefined
    ) {
        throw new AppError(
            'Units needed is required',
            400,
        );
    }

    if (
        data.radiusKm ===
        undefined
    ) {
        throw new AppError(
            'Radius is required',
            400,
        );
    }

    if (!data.status) {
        throw new AppError(
            'Status is required',
            400,
        );
    }


    // BLOOD GROUP VALIDATION

    if (
        !validBloodGroups.includes(
            data.bloodGroup,
        )
    ) {
        throw new AppError(
            'Invalid blood group',
            400,
        );
    }


    // ALERT STATUS VALIDATION

    if (
        !validAlertStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid alert status',
            400,
        );
    }


    // UNITS NEEDED VALIDATION

    if (
        typeof data.unitsNeeded !==
            'number' ||
        data.unitsNeeded <= 0
    ) {
        throw new AppError(
            'Units needed must be greater than 0',
            400,
        );
    }


    // RADIUS VALIDATION

    if (
        typeof data.radiusKm !==
            'number' ||
        data.radiusKm <= 0
    ) {
        throw new AppError(
            'Radius must be greater than 0',
            400,
        );
    }
};




// UPDATE EMERGENCY ALERT VALIDATOR

const validateUpdateEmergencyAlert = (
    data,
) => {

    if (
        data.bloodGroup &&
        !validBloodGroups.includes(
            data.bloodGroup,
        )
    ) {
        throw new AppError(
            'Invalid blood group',
            400,
        );
    }


    if (
        data.status &&
        !validAlertStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid alert status',
            400,
        );
    }


    if (
        data.unitsNeeded !==
            undefined &&
        (
            typeof data.unitsNeeded !==
                'number' ||
            data.unitsNeeded <= 0
        )
    ) {
        throw new AppError(
            'Units needed must be greater than 0',
            400,
        );
    }


    if (
        data.radiusKm !==
            undefined &&
        (
            typeof data.radiusKm !==
                'number' ||
            data.radiusKm <= 0
        )
    ) {
        throw new AppError(
            'Radius must be greater than 0',
            400,
        );
    }
};


module.exports = {
    validateCreateEmergencyAlert,
    validateUpdateEmergencyAlert,
};