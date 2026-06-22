const { db, admin, } =
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

const auditTrailService =
    require(
        './auditTrailService',
    );



const createLabTechnician =
    async (
        technicianData,
    ) => {

        const hospitalDoc =
            await hospitalCollection
                .doc(
                    technicianData.hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new AppError(
                'Hospital not found',
                404,
            );
        }

        const existingUser =
            await userCollection
                .where(
                    'email',
                    '==',
                    technicianData.email,
                )
                .limit(1)
                .get();

        if (!existingUser.empty) {
            throw new AppError(
                'Email already exists',
                400,
            );
        }

    const generatedPassword =
    Math.floor(
        100000 +
        Math.random() * 900000,
    ).toString();

const firebaseUser =
    await admin.auth()
        .createUser({
            email:
                technicianData.email,

            password:
                generatedPassword,
        });

        // CREATE USER
        const userRef =
            userCollection.doc(
                firebaseUser.uid,
            );

        const user = {
            userId: firebaseUser.uid,
            fullName:
                technicianData.fullName,
            email:
                technicianData.email,
            phoneNumber:
                technicianData.phoneNumber,
            role:
                'labTechnician',
            createdAt:
                new Date()
                    .toISOString(),
        };

        await userRef.set(user);

        // CREATE TECHNICIAN

        const technicianRef =
            labTechnicianCollection
                .doc(
                    firebaseUser.uid,
                );

        const technician = {
            technicianId:
                firebaseUser.uid,
            userId:
                firebaseUser.uid,
            hospitalId:
                technicianData.hospitalId,
            employeeId:
                technicianData.employeeId,
            department:
                technicianData.department,
            status:
                'Active',
            createdAt:
                new Date()
                    .toISOString(),
        };

        await technicianRef.set(
    technician,
);

        await auditTrailService
            .createAuditTrail({
                userId:
                    userRef.id,

                hospitalId:
                    technicianData.hospitalId,

                action:
                    'Lab Technician Created',

                targetEntity:
                    technicianRef.id,

                timestamp:
                    new Date()
                        .toISOString(),
            });

        return {
            technician,
            generatedPassword,
        };
    };




// UPDATE LAB TECHNICIAN
const updateLabTechnician =
    async (
        technicianId,
        updateData,
    ) => {

        console.log(
    'SERVICE UPDATE ID:',
    technicianId,
);

console.log(
    'SERVICE UPDATE DATA:',
    updateData,
);

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

        const technician =
            doc.data();

        // UPDATE USER

        const userUpdates = {};

        if (
            updateData.fullName !==
            undefined
        ) {
            userUpdates.fullName =
                updateData.fullName;
        }

        if (
            updateData.email !==
            undefined
        ) {
            userUpdates.email =
                updateData.email;
        }

        if (
            updateData.phoneNumber !==
            undefined
        ) {
            userUpdates.phoneNumber =
                updateData.phoneNumber;
        }

        if (
            Object.keys(
                userUpdates,
            ).length > 0
        ) {

            await userCollection
                .doc(
                    technician.userId,
                )
                .update(
                    userUpdates,
                );
        }

        // UPDATE TECHNICIAN
        const technicianUpdates =
            {};

        if (
            updateData.employeeId !==
            undefined
        ) {
            technicianUpdates.employeeId =
                updateData.employeeId;
        }

        if (
            updateData.department !==
            undefined
        ) {
            technicianUpdates.department =
                updateData.department;
        }

        if (
            updateData.status !==
            undefined
        ) {
            technicianUpdates.status =
                updateData.status;
        }

        if (
            Object.keys(
                technicianUpdates,
            ).length > 0
        ) {

            await docRef.update(
                technicianUpdates,
            );
        }

        await auditTrailService
            .createAuditTrail({
                userId:
                    technician.userId,

                hospitalId:
                    technician.hospitalId,

                action:
                    'Lab Technician Updated',

                targetEntity:
                    technicianId,

                timestamp:
                    new Date()
                        .toISOString(),
            });

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };


const getLabTechnician =
    async (technicianId) => {

        const doc =
            await labTechnicianCollection
                .doc(technicianId)
                .get();

        if (!doc.exists) {
            throw new AppError(
                'Lab technician not found',
                404,
            );
        }

        return doc.data();
    };



const getAllLabTechnicians =
    async () => {

        const snapshot =
            await labTechnicianCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// DELETE LAB TECHNICIAN
const deleteLabTechnician =
    async (
        technicianId,
    ) => {

        const technicianRef =
            labTechnicianCollection.doc(
                technicianId,
            );

        const technicianDoc =
            await technicianRef.get();

        if (!technicianDoc.exists) {
            throw new AppError(
                'Lab technician not found',
                404,
            );
        }

        const technician =
            technicianDoc.data();

        await userCollection
            .doc(
                technician.userId,
            )
            .delete();

        await technicianRef.delete();

        await auditTrailService
            .createAuditTrail({
                userId:
                    technician.userId,

                hospitalId:
                    technician.hospitalId,

                action:
                    'Lab Technician Deleted',

                targetEntity:
                    technicianId,

                timestamp:
                    new Date()
                        .toISOString(),
            });
    };


const getTechniciansByHospital =
    async (
        hospitalId,
    ) => {

        const snapshot =
            await labTechnicianCollection
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

    const getLabTechnicianByUserId =
    async (userId) => {

    const snapshot =
        await labTechnicianCollection
            .where(
                'userId',
                '==',
                userId,
            )
            .limit(1)
            .get();

    if (snapshot.empty) {
        return null;
    }

    return snapshot.docs[0].data();
};


module.exports = {
    createLabTechnician,
    getLabTechnician,
    getAllLabTechnicians,
    updateLabTechnician,
    deleteLabTechnician,
    getTechniciansByHospital,
    getLabTechnicianByUserId,
};