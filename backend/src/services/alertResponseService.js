const { db } =
    require('../config/firebase');



const alertResponseCollection =
    db.collection(
        'alert_responses',
    );

const emergencyAlertCollection =
    db.collection(
        'emergency_alerts',
    );

const donorCollection =
    db.collection(
        'donors',
    );

const userCollection =
    db.collection('users');

const notificationService =
    require('./notificationService');




// CREATE ALERT RESPONSE

const createAlertResponse =
    async (
        alertResponseData,
    ) => {

        // VALIDATE ALERT

        const alertDoc =
            await emergencyAlertCollection
                .doc(
                    alertResponseData
                        .alertId,
                )
                .get();

        if (!alertDoc.exists) {
            throw new Error(
                'Emergency alert not found',
            );
        }



        // VALIDATE DONOR

        const donorDoc =
            await donorCollection
                .doc(
                    alertResponseData
                        .donorId,
                )
                .get();

        if (!donorDoc.exists) {
            throw new Error(
                'Donor not found',
            );
        }



        // CHECK EXISTING RESPONSE

        const existingResponse =
            await alertResponseCollection
                .where(
                    'alertId',
                    '==',
                    alertResponseData
                        .alertId,
                )
                .where(
                    'donorId',
                    '==',
                    alertResponseData
                        .donorId,
                )
                .get();

        if (
            !existingResponse.empty
        ) {
            throw new Error(
                'Donor has already responded to this alert',
            );
        }



        // CREATE ALERT RESPONSE

        const alertResponseRef =
            alertResponseCollection
                .doc();

        const alertResponse = {

            responseId:
                alertResponseRef.id,

            ...alertResponseData,

            createdAt:
                new Date()
                    .toISOString(),
        };

        await alertResponseRef.set(
            alertResponse,
        );

        const alertData =
            alertDoc.data();
        const donorData =
            donorDoc.data();
        const donorUserDoc =
            await userCollection
                .doc(
                    donorData.userId ||
                        alertResponseData.donorId,
                )
                .get();
        const donorName =
            donorUserDoc.exists
                ? donorUserDoc.data().fullName
                : 'A donor';

        await notificationService
            .createNotification({
                userId:
                    alertData.technicianId,
                alertId:
                    alertResponseData.alertId,
                type:
                    'alertResponse',
                title:
                    'Emergency alert response',
                message:
                    `${donorName} ${alertResponseData.responseStatus} your emergency alert.`,
                isRead:
                    false,
                channel:
                    'push',
                deepLink:
                    `vitalmatch://lab/emergency-alerts/${alertResponseData.alertId}`,
                actions:
                    ['open'],
            });

        return alertResponse;
    };




// GET ALERT RESPONSE

const getAlertResponse =
    async (
        responseId,
    ) => {

        const doc =
            await alertResponseCollection
                .doc(
                    responseId,
                )
                .get();

        if (!doc.exists) {
            throw new Error(
                'Alert response not found',
            );
        }

        return doc.data();
    };




// GET ALL ALERT RESPONSES

const getAllAlertResponses =
    async () => {

        const snapshot =
            await alertResponseCollection
                .get();

        return snapshot.docs.map(
            (doc) =>
                doc.data(),
        );
    };




// UPDATE ALERT RESPONSE

const updateAlertResponse =
    async (
        responseId,
        updateData,
    ) => {

        const docRef =
            alertResponseCollection
                .doc(
                    responseId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Alert response not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE ALERT RESPONSE

const deleteAlertResponse =
    async (
        responseId,
    ) => {

        const docRef =
            alertResponseCollection
                .doc(
                    responseId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Alert response not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createAlertResponse,
    getAlertResponse,
    getAllAlertResponses,
    updateAlertResponse,
    deleteAlertResponse,
};
