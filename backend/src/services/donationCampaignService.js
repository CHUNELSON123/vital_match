const { db } =
    require('../config/firebase');


const donationCampaignCollection =
    db.collection(
        'donation_campaigns',
    );

const bloodBankCollection =
    db.collection(
        'blood_banks',
    );

const userCollection =
    db.collection('users');




// CREATE DONATION CAMPAIGN

const createDonationCampaign =
    async (
        donationCampaignData,
    ) => {

        // VALIDATE BLOOD BANK

        const bloodBankDoc =
            await bloodBankCollection
                .doc(
                    donationCampaignData
                        .bloodBankId,
                )
                .get();

        if (!bloodBankDoc.exists) {
            throw new Error(
                'Blood bank not found',
            );
        }



        // VALIDATE MANAGER

        const managerDoc =
            await userCollection
                .doc(
                    donationCampaignData
                        .managerId,
                )
                .get();

        if (!managerDoc.exists) {
            throw new Error(
                'Blood bank manager not found',
            );
        }

        const managerData =
            managerDoc.data();

        if (
            managerData.role !==
            'bloodBankManager'
        ) {
            throw new Error(
                'User is not a blood bank manager',
            );
        }



        // CREATE DONATION CAMPAIGN

        const donationCampaignRef =
            donationCampaignCollection
                .doc();

        const donationCampaign = {
            campaignId:
                donationCampaignRef.id,

            ...donationCampaignData,

            createdAt:
                new Date().toISOString(),
        };

        await donationCampaignRef.set(
            donationCampaign,
        );

        return donationCampaign;
    };




// GET DONATION CAMPAIGN

const getDonationCampaign =
    async (campaignId) => {

        const doc =
            await donationCampaignCollection
                .doc(campaignId)
                .get();

        if (!doc.exists) {
            throw new Error(
                'Donation campaign not found',
            );
        }

        return doc.data();
    };




// GET ALL DONATION CAMPAIGNS

const getAllDonationCampaigns =
    async () => {

        const snapshot =
            await donationCampaignCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE DONATION CAMPAIGN

const updateDonationCampaign =
    async (
        campaignId,
        updateData,
    ) => {

        const docRef =
            donationCampaignCollection
                .doc(campaignId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Donation campaign not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE DONATION CAMPAIGN

const deleteDonationCampaign =
    async (campaignId) => {

        const docRef =
            donationCampaignCollection
                .doc(campaignId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Donation campaign not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createDonationCampaign,
    getDonationCampaign,
    getAllDonationCampaigns,
    updateDonationCampaign,
    deleteDonationCampaign,
};