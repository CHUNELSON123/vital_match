const { db } =
    require('../config/firebase');


const healthTipCollection =
    db.collection(
        'health_tips',
    );




// CREATE HEALTH TIP

const createHealthTip =
    async (
        healthTipData,
    ) => {

        const healthTipRef =
            healthTipCollection
                .doc();

        const healthTip = {
            tipId:
                healthTipRef.id,

            ...healthTipData,
        };

        await healthTipRef.set(
            healthTip,
        );

        return healthTip;
    };




// GET HEALTH TIP

const getHealthTip =
    async (tipId) => {

        const doc =
            await healthTipCollection
                .doc(tipId)
                .get();

        if (!doc.exists) {
            throw new Error(
                'Health tip not found',
            );
        }

        return doc.data();
    };




// GET ALL HEALTH TIPS

const getAllHealthTips =
    async () => {

        const snapshot =
            await healthTipCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE HEALTH TIP

const updateHealthTip =
    async (
        tipId,
        updateData,
    ) => {

        const docRef =
            healthTipCollection
                .doc(tipId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Health tip not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE HEALTH TIP

const deleteHealthTip =
    async (tipId) => {

        const docRef =
            healthTipCollection
                .doc(tipId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Health tip not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createHealthTip,
    getHealthTip,
    getAllHealthTips,
    updateHealthTip,
    deleteHealthTip,
};