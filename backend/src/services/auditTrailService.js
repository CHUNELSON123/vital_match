const { db } =
    require('../config/firebase');


const auditTrailCollection =
    db.collection(
        'audit_trails',
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


module.exports = {
    createAuditTrail,
    getAuditTrail,
    getAllAuditTrails,
    getAuditTrailsByUser,
    updateAuditTrail,
    deleteAuditTrail,
};