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

        return emergencyAlert;
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