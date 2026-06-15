const AppError =
    require('../utils/appError');




// CREATE AUDIT TRAIL VALIDATOR

const validateCreateAuditTrail =
    (data) => {

        const {
            userId,
            action,
            targetEntity,
            timestamp,
        } = data;



        if (!userId) {
            throw new AppError(
                'User ID is required',
                400,
            );
        }

        if (!action) {
            throw new AppError(
                'Action is required',
                400,
            );
        }

        if (!targetEntity) {
            throw new AppError(
                'Target entity is required',
                400,
            );
        }

        if (!timestamp) {
            throw new AppError(
                'Timestamp is required',
                400,
            );
        }



        // DATE VALIDATION

        if (
            isNaN(
                Date.parse(
                    timestamp,
                ),
            )
        ) {
            throw new AppError(
                'Invalid timestamp',
                400,
            );
        }
    };




// UPDATE AUDIT TRAIL VALIDATOR

const validateUpdateAuditTrail =
    (data) => {

        const {
            action,
            targetEntity,
            timestamp,
        } = data;



        if (
            action !== undefined &&
            typeof action !== 'string'
        ) {
            throw new AppError(
                'Action must be a string',
                400,
            );
        }

        if (
            targetEntity !==
                undefined &&
            typeof targetEntity !==
                'string'
        ) {
            throw new AppError(
                'Target entity must be a string',
                400,
            );
        }

        if (
            timestamp &&
            isNaN(
                Date.parse(
                    timestamp,
                ),
            )
        ) {
            throw new AppError(
                'Invalid timestamp',
                400,
            );
        }
    };


module.exports = {
    validateCreateAuditTrail,
    validateUpdateAuditTrail,
};