const { db } =
    require('../config/firebase');


const bloodUnitCollection =
    db.collection('blood_units');



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

    await docRef.update(
        updateData,
    );

    const updatedDoc =
        await docRef.get();

    return updatedDoc.data();
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


module.exports = {
    createBloodUnit,
    getBloodUnit,
    updateBloodUnit,
    deleteBloodUnit,
};