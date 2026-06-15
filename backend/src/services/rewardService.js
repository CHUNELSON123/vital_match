const { db } =
    require('../config/firebase');


const rewardCollection =
    db.collection(
        'rewards',
    );

const donorCollection =
    db.collection(
        'donors',
    );




// CREATE REWARD

const createReward =
    async (rewardData) => {

        // VALIDATE DONOR

        const donorDoc =
            await donorCollection
                .doc(
                    rewardData.donorId,
                )
                .get();

        if (!donorDoc.exists) {
            throw new Error(
                'Donor not found',
            );
        }



        // CREATE REWARD

        const rewardRef =
            rewardCollection.doc();

        const reward = {
            rewardId:
                rewardRef.id,

            ...rewardData,
        };

        await rewardRef.set(
            reward,
        );

        return reward;
    };




// GET REWARD

const getReward =
    async (rewardId) => {

        const doc =
            await rewardCollection
                .doc(rewardId)
                .get();

        if (!doc.exists) {
            throw new Error(
                'Reward not found',
            );
        }

        return doc.data();
    };




// GET ALL REWARDS

const getAllRewards =
    async () => {

        const snapshot =
            await rewardCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// GET REWARDS BY DONOR

const getRewardsByDonor =
    async (donorId) => {

        const snapshot =
            await rewardCollection
                .where(
                    'donorId',
                    '==',
                    donorId,
                )
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE REWARD

const updateReward =
    async (
        rewardId,
        updateData,
    ) => {

        const docRef =
            rewardCollection.doc(
                rewardId,
            );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Reward not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE REWARD

const deleteReward =
    async (rewardId) => {

        const docRef =
            rewardCollection.doc(
                rewardId,
            );

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Reward not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createReward,
    getReward,
    getAllRewards,
    getRewardsByDonor,
    updateReward,
    deleteReward,
};