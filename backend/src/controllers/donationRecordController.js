const donationRecordService =
    require('../services/donationRecordService');

const {
    validateCreateDonationRecord,
    validateUpdateDonationRecord,
} = require('../validators/donationRecordValidator');




// CREATE DONATION RECORD

const createDonationRecord =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateDonationRecord(
                req.body,
            );

            const result =
                await donationRecordService
                    .createDonationRecord(
                        req.body,
                    );

            res.status(201).json({
                success: true,
                message:
                    'Donation record created successfully',
                data: result,
            });

        } catch (error) {
            next(error);
        }
    };




// GET DONATION RECORD

const getDonationRecord =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const donationRecord =
                await donationRecordService
                    .getDonationRecord(
                        req.params
                            .recordId,
                    );

            res.status(200).json({
                success: true,
                data: donationRecord,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL DONATION RECORDS

const getAllDonationRecords =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const donationRecords =
                await donationRecordService
                    .getAllDonationRecords();

            res.status(200).json({
                success: true,
                data: donationRecords,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE DONATION RECORD

const updateDonationRecord =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateDonationRecord(
                req.body,
            );

            const updatedDonationRecord =
                await donationRecordService
                    .updateDonationRecord(
                        req.params
                            .recordId,
                        req.body,
                    );

            res.status(200).json({
                success: true,
                message:
                    'Donation record updated successfully',
                data: updatedDonationRecord,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE DONATION RECORD

const deleteDonationRecord =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await donationRecordService
                .deleteDonationRecord(
                    req.params
                        .recordId,
                );

            res.status(200).json({
                success: true,
                message:
                    'Donation record deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };

    // GET DONATION RECORDS BY HOSPITAL

const getDonationRecordsByHospital =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const records =
                await donationRecordService
                    .getDonationRecordsByHospital(
                        req.params.hospitalId,
                    );

            res.status(200).json({
                success: true,
                data: records,
            });

        } catch (error) {
            next(error);
        }
    };

const getDonationRecordsByStatus =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const records =
                await donationRecordService
                    .getDonationRecordsByStatus(
                        req.params.status,
                    );

            res.status(200).json({
                success: true,
                data: records,
            });

        } catch (error) {
            next(error);
        }
    };

const getPendingDonationRecords =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const records =
                await donationRecordService
                    .getPendingDonationRecords();

            res.status(200).json({
                success: true,
                data: records,
            });

        } catch (error) {
            next(error);
        }
    };

module.exports = {
    createDonationRecord,
    getDonationRecord,
    getAllDonationRecords,
    updateDonationRecord,
    deleteDonationRecord,
    getDonationRecordsByHospital,
    getDonationRecordsByStatus,
    getPendingDonationRecords,
};