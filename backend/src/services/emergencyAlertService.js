const { db } =
    require('../config/firebase');

const AppError =
    require('../utils/appError');



const emergencyAlertCollection =
    db.collection(
        'emergency_alerts',
    );

const hospitalCollection =
    db.collection(
        'hospitals',
    );

const labTechnicianCollection =
    db.collection(
        'lab_technicians',
    );

const donorCollection =
    db.collection('donors');

const notificationService =
    require('./notificationService');

const distanceInKm = (
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
) => {
    const earthRadiusKm = 6371;
    const latitudeDistance =
        degreesToRadians(
            endLatitude - startLatitude,
        );
    const longitudeDistance =
        degreesToRadians(
            endLongitude - startLongitude,
        );
    const startLatitudeRadians =
        degreesToRadians(startLatitude);
    const endLatitudeRadians =
        degreesToRadians(endLatitude);

    const haversine =
        Math.sin(latitudeDistance / 2) *
            Math.sin(latitudeDistance / 2) +
        Math.cos(startLatitudeRadians) *
            Math.cos(endLatitudeRadians) *
            Math.sin(longitudeDistance / 2) *
            Math.sin(longitudeDistance / 2);

    return (
        earthRadiusKm *
        2 *
        Math.atan2(
            Math.sqrt(haversine),
            Math.sqrt(1 - haversine),
        )
    );
};

const degreesToRadians = (degrees) =>
    degrees * Math.PI / 180;

const normalizeBloodGroup = (value) => {
    const groups = {
        'A+': 'aPositive',
        'A-': 'aNegative',
        'B+': 'bPositive',
        'B-': 'bNegative',
        'AB+': 'abPositive',
        'AB-': 'abNegative',
        'O+': 'oPositive',
        'O-': 'oNegative',
    };

    return groups[value] || value;
};




// CREATE EMERGENCY ALERT

const createEmergencyAlert =
    async (
        emergencyAlertData,
    ) => {

        // VALIDATE HOSPITAL

        const hospitalDoc =
            await hospitalCollection
                .doc(
                    emergencyAlertData
                        .hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new AppError(
                'Hospital not found',
                404,
            );
        }



        // VALIDATE LAB TECHNICIAN

        const technicianDoc =
            await labTechnicianCollection
                .doc(
                    emergencyAlertData
                        .technicianId,
                )
                .get();

        if (
            !technicianDoc.exists
        ) {
            throw new AppError(
                'Lab technician not found',
                404,
            );
        }

        const technicianData =
            technicianDoc.data();



        // VERIFY TECHNICIAN BELONGS TO HOSPITAL

        if (
            technicianData.hospitalId !==
            emergencyAlertData
                .hospitalId
        ) {
            throw new AppError(
                'Lab technician does not belong to this hospital',
                400,
            );
        }



        // CREATE EMERGENCY ALERT

        const emergencyAlertRef =
            emergencyAlertCollection
                .doc();

        const emergencyAlert = {
            alertId:
                emergencyAlertRef.id,

            ...emergencyAlertData,

            createdAt:
                new Date().toISOString(),
        };

        await emergencyAlertRef.set(
            emergencyAlert,
        );

        await notifyMatchingDonors(
            emergencyAlert,
            hospitalDoc.data(),
        );

        return emergencyAlert;
    };

const notifyMatchingDonors =
    async (
        emergencyAlert,
        hospital,
    ) => {
        const donorSnapshot =
            await donorCollection.get();

        const donors =
            donorSnapshot.docs
                .map((doc) => ({
                    donorId: doc.id,
                    ...doc.data(),
                }))
                .filter((donor) => {
                    if (donor.isAvailable === false) {
                        return false;
                    }

                    if (
                        donor.bloodGroup &&
                        normalizeBloodGroup(
                            donor.bloodGroup,
                        ) !==
                            normalizeBloodGroup(
                                emergencyAlert.bloodGroup,
                            )
                    ) {
                        return false;
                    }

                    const distance =
                        distanceInKm(
                            donor.gpsLatitude,
                            donor.gpsLongitude,
                            hospital.latitude,
                            hospital.longitude,
                        );

                    return (
                        distance <=
                        emergencyAlert.radiusKm
                    );
                });

        await Promise.all(
            donors.map((donor) =>
                notificationService
                    .createNotification({
                        userId:
                            donor.userId ||
                            donor.donorId,
                        alertId:
                            emergencyAlert.alertId,
                        type:
                            'emergencyAlert',
                        title:
                            'Emergency blood request',
                        message:
                            `${hospital.name} urgently needs ${emergencyAlert.unitsNeeded} unit(s) of ${emergencyAlert.bloodGroup}.`,
                        isRead:
                            false,
                        channel:
                            'push',
                        deepLink:
                            `vitalmatch://donor/emergency-alerts/${emergencyAlert.alertId}`,
                        actions:
                            [
                                'accept',
                                'deny',
                                'viewAll',
                            ],
                    })
                    .catch((error) =>
                        console.error(
                            'Emergency alert donor notification failed:',
                            error.message,
                        ),
                    ),
            ),
        );
    };




// GET EMERGENCY ALERT

const getEmergencyAlert =
    async (alertId) => {

        const doc =
            await emergencyAlertCollection
                .doc(alertId)
                .get();

        if (!doc.exists) {
            throw new AppError(
                'Emergency alert not found',
                404,
            );
        }

        return doc.data();
    };




// GET ALL EMERGENCY ALERTS

const getAllEmergencyAlerts =
    async () => {

        const snapshot =
            await emergencyAlertCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE EMERGENCY ALERT

const updateEmergencyAlert =
    async (
        alertId,
        updateData,
    ) => {

        const docRef =
            emergencyAlertCollection
                .doc(alertId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Emergency alert not found',
                404,
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE EMERGENCY ALERT

const deleteEmergencyAlert =
    async (alertId) => {

        const docRef =
            emergencyAlertCollection
                .doc(alertId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Emergency alert not found',
                404,
            );
        }

        await docRef.delete();
    };

// GET EMERGENCY ALERTS BY HOSPITAL

const getEmergencyAlertsByHospital =
    async (
        hospitalId,
    ) => {

        const snapshot =
            await emergencyAlertCollection
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


module.exports = {
    createEmergencyAlert,
    getEmergencyAlert,
    getAllEmergencyAlerts,
    updateEmergencyAlert,
    deleteEmergencyAlert,
    getEmergencyAlertsByHospital,
};
