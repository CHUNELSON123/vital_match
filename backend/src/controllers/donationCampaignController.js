const donationCampaignService =
    require(
        '../services/donationCampaignService',
    );

const {
    validateCreateDonationCampaign,
    validateUpdateDonationCampaign,
} = require(
    '../validators/donationCampaignValidator',
);




// CREATE DONATION CAMPAIGN

const createDonationCampaign =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateDonationCampaign(
                req.body,
            );



            const donationCampaign =
                await donationCampaignService
                    .createDonationCampaign(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Donation campaign created successfully',
                data:
                    donationCampaign,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL DONATION CAMPAIGNS

const getAllDonationCampaigns =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const donationCampaigns =
                await donationCampaignService
                    .getAllDonationCampaigns();



            res.status(200).json({
                success: true,
                data:
                    donationCampaigns,
            });

        } catch (error) {
            next(error);
        }
    };




// GET DONATION CAMPAIGN

const getDonationCampaign =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const donationCampaign =
                await donationCampaignService
                    .getDonationCampaign(
                        req.params.campaignId,
                    );



            res.status(200).json({
                success: true,
                data:
                    donationCampaign,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE DONATION CAMPAIGN

const updateDonationCampaign =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateDonationCampaign(
                req.body,
            );



            const donationCampaign =
                await donationCampaignService
                    .updateDonationCampaign(
                        req.params.campaignId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Donation campaign updated successfully',
                data:
                    donationCampaign,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE DONATION CAMPAIGN

const deleteDonationCampaign =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await donationCampaignService
                .deleteDonationCampaign(
                    req.params.campaignId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Donation campaign deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createDonationCampaign,
    getAllDonationCampaigns,
    getDonationCampaign,
    updateDonationCampaign,
    deleteDonationCampaign,
};