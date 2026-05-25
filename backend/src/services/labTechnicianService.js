const { db } =
    require('../config/firebase');

const AppError =
    require('../utils/appError');



const labTechnicianCollection =
    db.collection(
        'lab_technicians',
    );

const userCollection =
    db.collection('users');

const hospitalCollection =
    db.collection('hospitals');




// CREATE LAB TECHNICIAN

const createLabTechnician =
    async (
        technicianData,
    ) => {

        // VALIDATE USER

        const userDoc =
            await userCollection
                .doc(
                    technicianData
                        .userId,
                )
                .get();

        if (!userDoc.exists) {
            throw new AppError(
                'User not found',
                404,
            );
        }

        const userData =
            userDoc.data();


        // VALIDATE ROLE

        if (
            userData.role !==
            'labTechnician'
        ) {
            throw new AppError(
                'User is not a lab technician',
                400,
            );
        }



        // VALIDATE HOSPITAL

        const hospitalDoc =
            await hospitalCollection
                .doc(
                    technicianData
                        .hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new AppError(
                'Hospital not found',
                404,
            );
        }



        // CHECK IF PROFILE EXISTS

        const existingSnapshot =
            await labTechnicianCollection
                .where(
                    'userId',
                    '==',
                    technicianData
                        .userId,
                )
                .get();

        if (
            !existingSnapshot.empty
        ) {
            throw new AppError(
                'Lab technician profile already exists',
                400,
            );
        }



        // CREATE PROFILE

        const technicianRef =
            labTechnicianCollection
                .doc();

        const technician = {
            technicianId:
                technicianRef.id,

            ...technicianData,

            createdAt:
                new Date().toISOString(),
        };

        await technicianRef.set(
            technician,
        );

        return technician;
    };




// GET LAB TECHNICIAN

const getLabTechnician =
    async (
        technicianId,
    ) => {

        const doc =
            await labTechnicianCollection
                .doc(
                    technicianId,
                )
                .get();

        if (!doc.exists) {
            throw new AppError(
                'Lab technician not found',
                404,
            );
        }

        return doc.data();
    };




// GET ALL LAB TECHNICIANS

const getAllLabTechnicians =
    async () => {

        const snapshot =
            await labTechnicianCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE LAB TECHNICIAN

const updateLabTechnician =
    async (
        technicianId,
        updateData,
    ) => {

        const docRef =
            labTechnicianCollection
                .doc(
                    technicianId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Lab technician not found',
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




// DELETE LAB TECHNICIAN

const deleteLabTechnician =
    async (
        technicianId,
    ) => {

        const docRef =
            labTechnicianCollection
                .doc(
                    technicianId,
                );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Lab technician not found',
                404,
            );
        }

        await docRef.delete();
    };


module.exports = {
    createLabTechnician,
    getLabTechnician,
    getAllLabTechnicians,
    updateLabTechnician,
    deleteLabTechnician,
};