const express =
    require('express');

const donationCampaignController =
    require(
        '../controllers/donationCampaignController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);

const {
    allowRoles,
} = require(
    '../middlewares/roleMiddleware',
);


const router =
    express.Router();




// CREATE DONATION CAMPAIGN

router.post(
    '/',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    donationCampaignController
        .createDonationCampaign,
);




// GET ALL DONATION CAMPAIGNS

router.get(
    '/',
    verifyToken,
    donationCampaignController
        .getAllDonationCampaigns,
);




// GET DONATION CAMPAIGN

router.get(
    '/:campaignId',
    verifyToken,
    donationCampaignController
        .getDonationCampaign,
);




// UPDATE DONATION CAMPAIGN

router.put(
    '/:campaignId',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    donationCampaignController
        .updateDonationCampaign,
);




// DELETE DONATION CAMPAIGN

router.delete(
    '/:campaignId',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    donationCampaignController
        .deleteDonationCampaign,
);


module.exports = router;