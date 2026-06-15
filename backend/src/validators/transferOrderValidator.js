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


const validTransferStatuses = [
    'pending',
    'approved',
    'dispatched',
    'delivered',
    'rejected',
];




// CREATE TRANSFER ORDER VALIDATOR

const validateCreateTransferOrder = (
    data,
) => {

    if (!data.hospitalId) {
        throw new AppError(
            'Hospital ID is required',
            400,
        );
    }

    if (!data.bloodBankId) {
        throw new AppError(
            'Blood bank ID is required',
            400,
        );
    }

    if (!data.managerId) {
        throw new AppError(
            'Manager ID is required',
            400,
        );
    }

    if (!data.bloodType) {
        throw new AppError(
            'Blood type is required',
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

    if (!data.status) {
        throw new AppError(
            'Transfer order status is required',
            400,
        );
    }

    if (!data.requestDate) {
        throw new AppError(
            'Request date is required',
            400,
        );
    }



    // BLOOD TYPE VALIDATION

    if (
        !validBloodTypes.includes(
            data.bloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }



    // STATUS VALIDATION

    if (
        !validTransferStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid transfer order status',
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
                data.requestDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid request date',
            400,
        );
    }
};




// UPDATE TRANSFER ORDER VALIDATOR

const validateUpdateTransferOrder = (
    data,
) => {

    if (
        data.bloodType &&
        !validBloodTypes.includes(
            data.bloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }


    if (
        data.status &&
        !validTransferStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid transfer order status',
            400,
        );
    }


    if (
        data.quantity !== undefined &&
        (
            typeof data.quantity !==
                'number' ||
            data.quantity <= 0
        )
    ) {
        throw new AppError(
            'Quantity must be greater than 0',
            400,
        );
    }


    if (
        data.requestDate &&
        isNaN(
            Date.parse(
                data.requestDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid request date',
            400,
        );
    }
};


module.exports = {
    validateCreateTransferOrder,
    validateUpdateTransferOrder,
};