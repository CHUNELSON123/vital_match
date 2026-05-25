const AppError =
    require('../utils/appError');


const validateCreateBloodBank = (
    data,
) => {

    if (!data.name) {
        throw new AppError(
            'Blood bank name is required',
            400,
        );
    }

    if (!data.address) {
        throw new AppError(
            'Address is required',
            400,
        );
    }

    if (!data.contactNumber) {
        throw new AppError(
            'Contact number is required',
            400,
        );
    }

    if (
        data.latitude === undefined
    ) {
        throw new AppError(
            'Latitude is required',
            400,
        );
    }

    if (
        data.longitude === undefined
    ) {
        throw new AppError(
            'Longitude is required',
            400,
        );
    }

    if (!data.regionCode) {
        throw new AppError(
            'Region code is required',
            400,
        );
    }

    if (
        data.storageCapacity === undefined
    ) {
        throw new AppError(
            'Storage capacity is required',
            400,
        );
    }


    // LATITUDE VALIDATION

    if (
        typeof data.latitude !==
            'number' ||
        data.latitude < -90 ||
        data.latitude > 90
    ) {
        throw new AppError(
            'Invalid latitude',
            400,
        );
    }


    // LONGITUDE VALIDATION

    if (
        typeof data.longitude !==
            'number' ||
        data.longitude < -180 ||
        data.longitude > 180
    ) {
        throw new AppError(
            'Invalid longitude',
            400,
        );
    }


    // STORAGE VALIDATION

    if (
        typeof data.storageCapacity !==
            'number' ||
        data.storageCapacity <= 0
    ) {
        throw new AppError(
            'Storage capacity must be greater than 0',
            400,
        );
    }
};



const validateUpdateBloodBank = (
    data,
) => {

    if (
        data.latitude !== undefined &&
        (
            typeof data.latitude !==
                'number' ||
            data.latitude < -90 ||
            data.latitude > 90
        )
    ) {
        throw new AppError(
            'Invalid latitude',
            400,
        );
    }


    if (
        data.longitude !== undefined &&
        (
            typeof data.longitude !==
                'number' ||
            data.longitude < -180 ||
            data.longitude > 180
        )
    ) {
        throw new AppError(
            'Invalid longitude',
            400,
        );
    }


    if (
        data.storageCapacity !==
            undefined &&
        (
            typeof data.storageCapacity !==
                'number' ||
            data.storageCapacity <= 0
        )
    ) {
        throw new AppError(
            'Storage capacity must be greater than 0',
            400,
        );
    }
};


module.exports = {
    validateCreateBloodBank,
    validateUpdateBloodBank,
};