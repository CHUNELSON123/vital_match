const { db } = require('../config/firebase');


const bloodBankCollection =
    db.collection('blood_banks');


// CREATE BLOOD BANK

const createBloodBank = async (
    bloodBankData,
) => {

    const docRef =
        bloodBankCollection.doc();

    const bloodBank = {
        bloodBankId: docRef.id,
        ...bloodBankData,
        createdAt:
            new Date().toISOString(),
    };

    await docRef.set(bloodBank);

    return bloodBank;
};


// GET BLOOD BANK

const getBloodBank = async (
    bloodBankId,
) => {

    const doc =
        await bloodBankCollection
            .doc(bloodBankId)
            .get();

    if (!doc.exists) {
        throw new Error(
            'Blood bank not found',
        );
    }

    return doc.data();
};


// UPDATE BLOOD BANK

const updateBloodBank = async (
    bloodBankId,
    updateData,
) => {

    const docRef =
        bloodBankCollection.doc(
            bloodBankId,
        );

    const doc = await docRef.get();

    if (!doc.exists) {
        throw new Error(
            'Blood bank not found',
        );
    }

    await docRef.update(updateData);

    const updatedDoc =
        await docRef.get();

    return updatedDoc.data();
};


// DELETE BLOOD BANK

const deleteBloodBank = async (
    bloodBankId,
) => {

    const docRef =
        bloodBankCollection.doc(
            bloodBankId,
        );

    const doc = await docRef.get();

    if (!doc.exists) {
        throw new Error(
            'Blood bank not found',
        );
    }

    await docRef.delete();
};


module.exports = {
    createBloodBank,
    getBloodBank,
    updateBloodBank,
    deleteBloodBank,
};