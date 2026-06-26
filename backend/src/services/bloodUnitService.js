const { db } =
    require('../config/firebase');


const bloodUnitCollection =
    db.collection('blood_units');

const auditTrailService =
    require('./auditTrailService');



// CREATE BLOOD UNIT
const createBloodUnit = async (
    bloodUnitData,
) => {

    // ONLY ONE STORAGE LOCATION ALLOWED

    if (
        bloodUnitData.hospitalId &&
        bloodUnitData.bloodBankId
    ) {
        throw new Error(
            'Blood unit cannot belong to both hospital and blood bank',
        );
    }


    // VALIDATE HOSPITAL

    if (bloodUnitData.hospitalId) {

        const hospitalDoc =
            await db
                .collection(
                    'hospitals',
                )
                .doc(
                    bloodUnitData.hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new Error(
                'Hospital not found',
            );
        }
    }


    // VALIDATE BLOOD BANK

    if (bloodUnitData.bloodBankId) {

        const bloodBankDoc =
            await db
                .collection(
                    'blood_banks',
                )
                .doc(
                    bloodUnitData.bloodBankId,
                )
                .get();

        if (!bloodBankDoc.exists) {
            throw new Error(
                'Blood bank not found',
            );
        }
    }


    const docRef =
        bloodUnitCollection.doc();

    const bloodUnit = {
        bloodUnitId: docRef.id,
        ...bloodUnitData,
        bloodType:
            bloodUnitData.bloodType ||
            bloodUnitData.bloodGroup,
        bloodGroup:
            bloodUnitData.bloodGroup ||
            bloodUnitData.bloodType,
        createdAt:
            new Date().toISOString(),
    };

    await docRef.set(
        bloodUnit,
    );

    return bloodUnit;
};


// GET BLOOD UNIT

const getBloodUnit = async (
    bloodUnitId,
) => {

    const doc =
        await bloodUnitCollection
            .doc(bloodUnitId)
            .get();

    if (!doc.exists) {
        throw new Error(
            'Blood unit not found',
        );
    }

    return doc.data();
};



// UPDATE BLOOD UNIT

const updateBloodUnit = async (
    bloodUnitId,
    updateData,
) => {

    const docRef =
        bloodUnitCollection.doc(
            bloodUnitId,
        );

    const doc =
        await docRef.get();

    if (!doc.exists) {
        throw new Error(
            'Blood unit not found',
        );
    }

    const existingBloodUnit =
        doc.data();

    const normalizedUpdate = {
        ...updateData,
    };

    if (
        updateData.bloodType ||
        updateData.bloodGroup
    ) {
        normalizedUpdate.bloodType =
            updateData.bloodType ||
            updateData.bloodGroup;
        normalizedUpdate.bloodGroup =
            updateData.bloodGroup ||
            updateData.bloodType;
    }

    await docRef.update(
        normalizedUpdate,
    );

    const updatedDoc =
        await docRef.get();

    const updatedBloodUnit =
        updatedDoc.data();

    if (
        updateData.updatedBy &&
        updateData.quantity !== undefined &&
        existingBloodUnit.quantity !==
            updateData.quantity
    ) {
        const unitsUsed =
            Math.max(
                0,
                existingBloodUnit.quantity -
                    updateData.quantity,
            );

        await auditTrailService
            .createAuditTrail({
                userId:
                    updateData.updatedBy,
                hospitalId:
                    updatedBloodUnit.hospitalId ||
                    existingBloodUnit.hospitalId,
                action:
                    unitsUsed > 0
                        ? `Blood Unit Used (${unitsUsed} unit${unitsUsed === 1 ? '' : 's'})`
                        : 'Blood Unit Updated',
                targetEntity:
                    bloodUnitId,
                timestamp:
                    new Date().toISOString(),
            });
    }

    return updatedBloodUnit;
};



// DELETE BLOOD UNIT

const deleteBloodUnit = async (
    bloodUnitId,
) => {

    const docRef =
        bloodUnitCollection.doc(
            bloodUnitId,
        );

    const doc =
        await docRef.get();

    if (!doc.exists) {
        throw new Error(
            'Blood unit not found',
        );
    }

    await docRef.delete();
};

// GET BLOOD UNITS BY HOSPITAL

const getBloodUnitsByHospital =
    async (
        hospitalId,
    ) => {

        const snapshot =
            await bloodUnitCollection
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

const getAllBloodUnits =
    async () => {

        const snapshot =
            await bloodUnitCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };


module.exports = {
    createBloodUnit,
    getBloodUnit,
    updateBloodUnit,
    deleteBloodUnit,
    getBloodUnitsByHospital,
    getAllBloodUnits,
};
