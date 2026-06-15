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


const validCampaignStatuses = [
    'upcoming',
    'ongoing',
    'completed',
    'cancelled',
];




// CREATE DONATION CAMPAIGN VALIDATOR

const validateCreateDonationCampaign = (
    data,
) => {

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

    if (!data.title) {
        throw new AppError(
            'Title is required',
            400,
        );
    }

    if (!data.description) {
        throw new AppError(
            'Description is required',
            400,
        );
    }

    if (!data.targetBloodType) {
        throw new AppError(
            'Target blood type is required',
            400,
        );
    }

    if (!data.campaignDate) {
        throw new AppError(
            'Campaign date is required',
            400,
        );
    }

    if (!data.location) {
        throw new AppError(
            'Location is required',
            400,
        );
    }

    if (!data.status) {
        throw new AppError(
            'Campaign status is required',
            400,
        );
    }



    // BLOOD TYPE VALIDATION

    if (
        !validBloodTypes.includes(
            data.targetBloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }



    // STATUS VALIDATION

    if (
        !validCampaignStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid campaign status',
            400,
        );
    }



    // DATE VALIDATION

    if (
        isNaN(
            Date.parse(
                data.campaignDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid campaign date',
            400,
        );
    }
};




// UPDATE DONATION CAMPAIGN VALIDATOR

const validateUpdateDonationCampaign = (
    data,
) => {

    if (
        data.targetBloodType &&
        !validBloodTypes.includes(
            data.targetBloodType,
        )
    ) {
        throw new AppError(
            'Invalid blood type',
            400,
        );
    }


    if (
        data.status &&
        !validCampaignStatuses.includes(
            data.status,
        )
    ) {
        throw new AppError(
            'Invalid campaign status',
            400,
        );
    }


    if (
        data.campaignDate &&
        isNaN(
            Date.parse(
                data.campaignDate,
            ),
        )
    ) {
        throw new AppError(
            'Invalid campaign date',
            400,
        );
    }
};


module.exports = {
    validateCreateDonationCampaign,
    validateUpdateDonationCampaign,
};