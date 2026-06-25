const { db } =
    require('../config/firebase');



const donationRecordCollection =
    db.collection(
        'donation_records',
    );

const donorCollection =
    db.collection('donors');

const hospitalCollection =
    db.collection('hospitals');

const userCollection =
    db.collection('users');

const bloodUnitCollection =
    db.collection('blood_units');

const notificationService =
    require('./notificationService');




// CREATE DONATION RECORD

const createDonationRecord = async (
    donationRecordData,
) => {

    // VALIDATE DONOR

    const donorDoc =
        await donorCollection
            .doc(
                donationRecordData
                    .donorId,
            )
            .get();

    if (!donorDoc.exists) {
        throw new Error(
            'Donor not found',
        );
    }



    // VALIDATE HOSPITAL

    const hospitalDoc =
        await hospitalCollection
            .doc(
                donationRecordData
                    .hospitalId,
            )
            .get();

    if (!hospitalDoc.exists) {
        throw new Error(
            'Hospital not found',
        );
    }



    // VALIDATE TECHNICIAN

    const technicianDoc =
        await userCollection
            .doc(
                donationRecordData
                    .technicianId,
            )
            .get();

    if (!technicianDoc.exists) {
        throw new Error(
            'Lab technician not found',
        );
    }

    const technicianData =
        technicianDoc.data();

    if (
        technicianData.role !==
        'labTechnician'
    ) {
        throw new Error(
            'User is not a lab technician',
        );
    }



    // CREATE DONATION RECORD

    const donationRecordRef =
        donationRecordCollection.doc();

    const donationRecord = {
        recordId:
            donationRecordRef.id,

        ...donationRecordData,

        createdAt:
            new Date().toISOString(),
    };

    await donationRecordRef.set(
        donationRecord,
    );



    // AUTOMATIC BLOOD UNIT CREATION

    const bloodUnitRef =
        bloodUnitCollection.doc();

    const bloodUnit = {
        bloodUnitId:
            bloodUnitRef.id,

        recordId:
            donationRecordRef.id,

        hospitalId:
            donationRecordData
                .hospitalId,

        bloodGroup:
            donationRecordData
                .bloodGroup,

        componentType:
            'Whole Blood',

        storageStatus:
            'available',

        quantity:
            donationRecordData
                .bloodUnitsCollected,

        collectionDate:
            donationRecordData
                .donationDate,

        expiryDate:
            new Date(
                new Date(
                    donationRecordData
                        .donationDate,
                ).setDate(
                    new Date(
                        donationRecordData
                            .donationDate,
                    ).getDate() + 42,
                ),
            ).toISOString(),
    };

    await bloodUnitRef.set(
        bloodUnit,
    );



    return {
        donationRecord,
        bloodUnit,
    };
};




// GET DONATION RECORD

const getDonationRecord = async (
    recordId,
) => {

    const doc =
        await donationRecordCollection
            .doc(recordId)
            .get();

    if (!doc.exists) {
        throw new Error(
            'Donation record not found',
        );
    }

    return doc.data();
};




// GET ALL DONATION RECORDS

const getAllDonationRecords =
    async () => {

        const snapshot =
            await donationRecordCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE DONATION RECORD

const updateDonationRecord =
    async (
        recordId,
        updateData,
    ) => {

        const docRef =
            donationRecordCollection
                .doc(recordId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Donation record not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        const updatedDonation =
            updatedDoc.data();

        if (
            updateData.status === 'verified' ||
            updateData.status === 'rejected'
        ) {
            const title =
                updateData.status === 'verified'
                    ? 'Donation verified'
                    : 'Donation rejected';

            const message =
                updateData.status === 'verified'
                    ? 'Your donation has been verified. Thank you for saving lives.'
                    : 'Your donation could not be verified. Please contact the hospital for details.';

            await notificationService
                .createNotification({
                    userId:
                        updatedDonation.donorId,
                    alertId:
                        updatedDonation.recordId,
                    type:
                        'donationStatus',
                    title,
                    message,
                    isRead:
                        false,
                    channel:
                        'whatsappLink',
                    deepLink:
                        `vitalmatch://donor/donations/${updatedDonation.recordId}`,
                    actions:
                        ['open'],
                });
        }

        return updatedDonation;
    };




// DELETE DONATION RECORD

const deleteDonationRecord =
    async (recordId) => {

        const docRef =
            donationRecordCollection
                .doc(recordId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Donation record not found',
            );
        }

        await docRef.delete();
    };

    // GET DONATION RECORDS BY HOSPITAL

const getDonationRecordsByHospital =
    async (
        hospitalId,
    ) => {

        const snapshot =
            await donationRecordCollection
                .where(
                    'hospitalId',
                    '==',
                    hospitalId,
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };

const getDonationRecordsByStatus =
    async (
        status,
    ) => {

        const snapshot =
            await donationRecordCollection
                .where(
                    'status',
                    '==',
                    status,
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };

const getPendingDonationRecords =
    async () => {

        const snapshot =
            await donationRecordCollection
                .where(
                    'status',
                    '==',
                    'pending',
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
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
