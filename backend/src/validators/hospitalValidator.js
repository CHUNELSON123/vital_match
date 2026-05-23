const AppError = require('../utils/appError');

const validateCreateHospital = (data) => {

    if (!data.name) {
        throw new AppError(
            'Hospital name is required',
            400,
        );
    }

    if (!data.address) {
        throw new AppError(
            'Hospital address is required',
            400,
        );
    }

    if (!data.contactNumber) {
        throw new AppError(
            'Contact number is required',
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
    if (typeof data.latitude !== 'number') {
        throw new AppError(
            'Latitude must be a number',
            400,
        );
    }

    // Longitude validation
    if (typeof data.longitude !== 'number') {
        throw new AppError(
            'Longitude must be a number',
            400,
        );
    }

    // Geofence validation
    if (typeof data.geofenceRadiusKm !== 'number') {
        throw new AppError(
            'Geofence radius must be a number',
            400,
        );
    }
};

const validateUpdateHospital = (data) => {

    if (
        data.latitude !== undefined &&
        typeof data.latitude !== 'number'
    ) {
        throw new AppError(
            'Latitude must be a number',
            400,
        );
    }

    if (
        data.longitude !== undefined &&
        typeof data.longitude !== 'number'
    ) {
        throw new AppError(
            'Longitude must be a number',
            400,
        );
    }

    if (
        data.geofenceRadiusKm !== undefined &&
        typeof data.geofenceRadiusKm !== 'number'
    ) {
        throw new AppError(
            'Geofence radius must be a number',
            400,
        );
    }
};

module.exports = {
    validateCreateHospital,
    validateUpdateHospital,
};