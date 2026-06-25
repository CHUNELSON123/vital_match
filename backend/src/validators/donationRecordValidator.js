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

const donationStatuses = [
    'pending',
    'verified',
    'rejected',
];



// CREATE DONATION RECORD VALIDATOR

const validateCreateDonationRecord = (
    data,
) => {

    if (!data.donorId) {
        throw new AppError(
            'Donor ID is required',
            400,
        );
    }

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

    if (!data.donationDate) {
        throw new AppError(
            'Donation date is required',
            400,
        );
    }

    if (
        data.bloodUnitsCollected ===
        undefined
    ) {
        throw new AppError(
            'Blood units collected is required',
            400,
        );
    }

    if (
        data.pointsAwarded ===
        undefined
    ) {
        throw new AppError(
            'Points awarded is required',
            400,
        );
    }

    if (!data.bloodGroup) {
        throw new AppError(
            'Blood group is required',
            400,
        );
    }

    if (data.donorWeight === undefined) {
        throw new AppError(
            'Donor weight is required',
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


    // DATE VALIDATION

    if (
        isNaN(
            Date.parse(
                data.donationDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid donation date',
            400,
        );
    }


    // BLOOD UNITS VALIDATION

    if (
        typeof data
            .bloodUnitsCollected !==
            'number' ||
        data.bloodUnitsCollected <=
            0
    ) {
        throw new AppError(
            'Blood units collected must be greater than 0',
            400,
        );
    }


    // POINTS VALIDATION

    if (
        typeof data.pointsAwarded !==
            'number' ||
        data.pointsAwarded < 0
    ) {
        throw new AppError(
            'Points awarded cannot be negative',
            400,
        );
    }

    if (
        typeof data.donorWeight !==
            'number' ||
        data.donorWeight < 50
    ) {
        throw new AppError(
            'Donor weight must be at least 50 kg',
            400,
        );
    }
};




// UPDATE DONATION RECORD VALIDATOR

const validateUpdateDonationRecord = (
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
        data.donationDate &&
        isNaN(
            Date.parse(
                data.donationDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid donation date',
            400,
        );
    }


    if (
        data.bloodUnitsCollected !==
            undefined &&
        (
            typeof data
                .bloodUnitsCollected !==
                'number' ||
            data.bloodUnitsCollected <=
                0
        )
    ) {
        throw new AppError(
            'Blood units collected must be greater than 0',
            400,
        );
    }


    if (
        data.pointsAwarded !==
            undefined &&
        (
            typeof data
                .pointsAwarded !==
                'number' ||
            data.pointsAwarded < 0
        )
    ) {
        throw new AppError(
            'Points awarded cannot be negative',
            400,
        );
    }

    if (
        data.donorWeight !== undefined &&
        (
            typeof data.donorWeight !==
                'number' ||
            data.donorWeight < 50
        )
    ) {
        throw new AppError(
            'Donor weight must be at least 50 kg',
            400,
        );
    }

    if (
    data.status &&
    !donationStatuses.includes(
        data.status,
    )
) {
    throw new AppError(
        'Invalid donation status',
        400,
    );
}
};


module.exports = {
    validateCreateDonationRecord,
    validateUpdateDonationRecord,
};
