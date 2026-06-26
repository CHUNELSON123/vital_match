const AppError =
    require('../utils/appError');


const validBloodTypes = [
    'aPositive',
    'aNegative',
    'bPositive',
    'bNegative',
    'abPositive',
    'abNegative',
    'oPositive',
    'oNegative',
];


const validStorageStatuses = [
    'available',
    'reserved',
    'expired',
    'transferred',
    'discarded',
];



// CREATE BLOOD UNIT VALIDATOR

const validateCreateBloodUnit = (
    data,
) => {

    if (!data.recordId) {
        throw new AppError(
            'Record ID is required',
            400,
        );
    }

    const bloodType =
        data.bloodType ||
        data.bloodGroup;

    if (!bloodType) {
        throw new AppError(
            'Blood type is required',
            400,
        );
    }

    if (!data.componentType) {
        throw new AppError(
            'Component type is required',
            400,
        );
    }

    if (
        data.quantity === undefined
    ) {
        throw new AppError(
            'Quantity is required',
            400,
        );
    }

    if (!data.collectionDate) {
        throw new AppError(
            'Collection date is required',
            400,
        );
    }

    if (!data.expiryDate) {
        throw new AppError(
            'Expiry date is required',
            400,
        );
    }

    if (!data.storageStatus) {
        throw new AppError(
            'Storage status is required',
            400,
        );
    }


    // BLOOD TYPE VALIDATION

    if (
        !validBloodTypes.includes(
            bloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }


    // STORAGE STATUS VALIDATION

    if (
        !validStorageStatuses.includes(
            data.storageStatus,
        )
    ) {
        throw new AppError(
            'Invalid storage status',
            400,
        );
    }


    // QUANTITY VALIDATION

    if (
        typeof data.quantity !==
            'number' ||
        data.quantity <= 0
    ) {
        throw new AppError(
            'Quantity must be greater than 0',
            400,
        );
    }


    // DATE VALIDATION

    if (
        isNaN(
            Date.parse(
                data.collectionDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid collection date',
            400,
        );
    }

    if (
        isNaN(
            Date.parse(
                data.expiryDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid expiry date',
            400,
        );
    }


    // LOCATION VALIDATION

    if (
        !data.hospitalId &&
        !data.bloodBankId
    ) {
        throw new AppError(
            'Blood unit must belong to a hospital or blood bank',
            400,
        );
    }
};




// UPDATE BLOOD UNIT VALIDATOR

const validateUpdateBloodUnit = (
    data,
) => {

    const bloodType =
        data.bloodType ||
        data.bloodGroup;

    if (
        bloodType &&
        !validBloodTypes.includes(
            bloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }


    if (
        data.storageStatus &&
        !validStorageStatuses.includes(
            data.storageStatus,
        )
    ) {
        throw new AppError(
            'Invalid storage status',
            400,
        );
    }


    if (
        data.quantity !== undefined &&
        (
            typeof data.quantity !==
                'number' ||
            data.quantity < 0
        )
    ) {
        throw new AppError(
            'Quantity cannot be less than 0',
            400,
        );
    }


    if (
        data.collectionDate &&
        isNaN(
            Date.parse(
                data.collectionDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid collection date',
            400,
        );
    }


    if (
        data.expiryDate &&
        isNaN(
            Date.parse(
                data.expiryDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid expiry date',
            400,
        );
    }
};


module.exports = {
    validateCreateBloodUnit,
    validateUpdateBloodUnit,
};
