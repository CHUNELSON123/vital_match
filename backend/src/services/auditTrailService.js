const { db } =
    require('../config/firebase');


const auditTrailCollection =
    db.collection(
        'audit_trails',
    );

const userCollection =
    db.collection('users');

const labTechnicianCollection =
    db.collection(
        'lab_technicians',
    );




// CREATE AUDIT TRAIL

const createAuditTrail =
    async (
        auditTrailData,
    ) => {

        const auditTrailRef =
            auditTrailCollection
                .doc();

        const auditTrail = {
            auditId:
                auditTrailRef.id,

            ...auditTrailData,
        };

        await auditTrailRef.set(
            auditTrail,
        );

        return auditTrail;
    };




// GET AUDIT TRAIL

const getAuditTrail =
    async (auditId) => {

        const doc =
            await auditTrailCollection
                .doc(auditId)
                .get();

        if (!doc.exists) {
            throw new Error(
                'Audit trail not found',
            );
        }

        return doc.data();
    };




// GET ALL AUDIT TRAILS

const getAllAuditTrails =
    async () => {

        const snapshot =
            await auditTrailCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// GET AUDIT TRAILS BY USER

const getAuditTrailsByUser =
    async (userId) => {

        const snapshot =
            await auditTrailCollection
                .where(
                    'userId',
                    '==',
                    userId,
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE AUDIT TRAIL

const updateAuditTrail =
    async (
        auditId,
        updateData,
    ) => {

        const docRef =
            auditTrailCollection
                .doc(auditId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Audit trail not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE AUDIT TRAIL

const deleteAuditTrail =
    async (auditId) => {

        const docRef =
            auditTrailCollection
                .doc(auditId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Audit trail not found',
            );
        }

        await docRef.delete();
    };

const getAuditTrailsByHospital =
    async (hospitalId) => {

        const snapshot =
            await auditTrailCollection
                .where(
                    'hospitalId',
                    '==',
                    hospitalId,
                )
                .get();

        const auditTrails =
            await Promise.all(

                snapshot.docs.map(
                    async (doc) => {

                        const audit =
                            doc.data();

                        let userName =
                            audit.userId;

                        let targetName =
                            audit.targetEntity;

                        // USER NAME

                        const userDoc =
                            await userCollection
                                .doc(
                                    audit.userId,
                                )
                                .get();

                        if (
                            userDoc.exists
                        ) {

                            userName =
                                userDoc.data()
                                    .fullName;
                        }

                        // TARGET NAME

                        const technicianDoc =
                            await labTechnicianCollection
                                .doc(
                                    audit.targetEntity,
                                )
                                .get();

                        if (
                            technicianDoc.exists
                        ) {

                            const technician =
                                technicianDoc.data();

                            const targetUserDoc =
                                await userCollection
                                    .doc(
                                        technician.userId,
                                    )
                                    .get();

                            if (
                                targetUserDoc.exists
                            ) {

                                targetName =
                                    targetUserDoc
                                        .data()
                                        .fullName;
                            }
                        }

                        return {
                            ...audit,
                            userName,
                            targetName,
                        };
                    },
                ),
            );

        return auditTrails;
    };
    
module.exports = {
    createAuditTrail,
    getAuditTrail,
    getAllAuditTrails,
    getAuditTrailsByUser,
    updateAuditTrail,
    deleteAuditTrail,
    getAuditTrailsByHospital,
};