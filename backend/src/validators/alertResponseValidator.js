const AppError =
    require('../utils/appError');



const validAlertResponseStatuses = [
    'pending',
    'accepted',
    'rejected',
    'completed',
];




// CREATE ALERT RESPONSE VALIDATOR

const validateCreateAlertResponse = (
    data,
) => {

    if (!data.alertId) {
        throw new AppError(
            'Alert ID is required',
            400,
        );
    }

    if (!data.donorId) {
        throw new AppError(
            'Donor ID is required',
            400,
        );
    }

    if (!data.responseStatus) {
        throw new AppError(
            'Response status is required',
            400,
        );
    }

    if (!data.responseDate) {
        throw new AppError(
            'Response date is required',
            400,
        );
    }



    // RESPONSE STATUS VALIDATION

    if (
        !validAlertResponseStatuses.includes(
            data.responseStatus,
        )
    ) {
        throw new AppError(
            'Invalid response status',
            400,
        );
    }



    // DATE VALIDATION

    if (
        isNaN(
            Date.parse(
                data.responseDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid response date',
            400,
        );
    }
};




// UPDATE ALERT RESPONSE VALIDATOR

const validateUpdateAlertResponse = (
    data,
) => {

    if (
        data.responseStatus &&
        !validAlertResponseStatuses.includes(
            data.responseStatus,
        )
    ) {
        throw new AppError(
            'Invalid response status',
            400,
        );
    }



    if (
        data.responseDate &&
        isNaN(
            Date.parse(
                data.responseDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid response date',
            400,
        );
    }
};


module.exports = {
    validateCreateAlertResponse,
    validateUpdateAlertResponse,
};