const AppError = require('../utils/appError');

const phoneRegex =
    /^(\+237\s?)?6[0-9]{8}$/;

const validateCreateHospital = (data) => {

    if (!data.name || data.name.trim() === '') {
        throw new AppError(
            'Hospital name is required',
            400,
        );
    }

    if (data.name.trim().length < 3) {
        throw new AppError(
            'Hospital name must be at least 3 characters',
            400,
        );
    }

    if (!data.address || data.address.trim() === '') {
        throw new AppError(
            'Hospital address is required',
            400,
        );
    }

    if (data.address.trim().length < 3) {
        throw new AppError(
            'Hospital address must be at least 3 characters',
            400,
        );
    }

    if (!data.contactNumber || data.contactNumber.trim() === '') {
        throw new AppError(
            'Contact number is required',
            400,
        );
    }

    if (!phoneRegex.test(data.contactNumber.trim())) {
        throw new AppError(
            'Invalid contact number',
            400,
        );
    }

    if (data.latitude === undefined) {
        throw new AppError(
            'Latitude is required',
            400,
        );
    }

    if (data.longitude === undefined) {
        throw new AppError(
            'Longitude is required',
            400,
        );
    }

    if (data.geofenceRadiusKm === undefined) {
        throw new AppError(
            'Geofence radius is required',
            400,
        );
    }

    // Latitude validation
    if (
        typeof data.latitude !== 'number' ||
        data.latitude < -90 ||
        data.latitude > 90
    ) {
        throw new AppError(
            'Latitude must be a number between -90 and 90',
            400,
        );
    }

    // Longitude validation
    if (
        typeof data.longitude !== 'number' ||
        data.longitude < -180 ||
        data.longitude > 180
    ) {
        throw new AppError(
            'Longitude must be a number between -180 and 180',
            400,
        );
    }

    // Geofence validation
    if (
        typeof data.geofenceRadiusKm !== 'number' ||
        data.geofenceRadiusKm <= 0
    ) {
        throw new AppError(
            'Geofence radius must be a positive number',
            400,
        );
    }
};

const validateUpdateHospital = (data) => {

    if (
        data.name !== undefined &&
        data.name.trim() === ''
    ) {
        throw new AppError(
            'Hospital name cannot be empty',
            400,
        );
    }

    if (
        data.address !== undefined &&
        data.address.trim() === ''
    ) {
        throw new AppError(
            'Hospital address cannot be empty',
            400,
        );
    }

    if (
        data.contactNumber !== undefined &&
        !phoneRegex.test(data.contactNumber.trim())
    ) {
        throw new AppError(
            'Invalid contact number',
            400,
        );
    }

    if (
        data.latitude !== undefined &&
        (
            typeof data.latitude !== 'number' ||
            data.latitude < -90 ||
            data.latitude > 90
        )
    ) {
        throw new AppError(
            'Latitude must be a number between -90 and 90',
            400,
        );
    }

    if (
        data.longitude !== undefined &&
        (
            typeof data.longitude !== 'number' ||
            data.longitude < -180 ||
            data.longitude > 180
        )
    ) {
        throw new AppError(
            'Longitude must be a number between -180 and 180',
            400,
        );
    }

    if (
        data.geofenceRadiusKm !== undefined &&
        (
            typeof data.geofenceRadiusKm !== 'number' ||
            data.geofenceRadiusKm <= 0
        )
    ) {
        throw new AppError(
            'Geofence radius must be a positive number',
            400,
        );
    }
};

module.exports = {
    validateCreateHospital,
    validateUpdateHospital,
};
