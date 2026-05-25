const { db } =
    require('../config/firebase');

const AppError =
    require('../utils/appError');



const bloodBankManagerCollection =
    db.collection(
        'blood_bank_managers',
    );

const userCollection =
    db.collection('users');

const bloodBankCollection =
    db.collection(
        'blood_banks',
    );




// CREATE BLOOD BANK MANAGER

const createBloodBankManager =
    async (
        managerData,
    ) => {

        // VALIDATE USER

        const userDoc =
            await userCollection
                .doc(
                    managerData.userId,
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
            'bloodBankManager'
        ) {

            throw new AppError(
                'User is not a blood bank manager',
                400,
            );
        }



        // VALIDATE BLOOD BANK

        const bloodBankDoc =
            await bloodBankCollection
                .doc(
                    managerData
                        .bloodBankId,
                )
                .get();

        if (
            !bloodBankDoc.exists
        ) {

            throw new AppError(
                'Blood bank not found',
                404,
            );
        }



        // CHECK IF PROFILE EXISTS

        const existingSnapshot =
            await bloodBankManagerCollection
                .where(
                    'userId',
                    '==',
                    managerData.userId,
                )
                .get();

        if (
            !existingSnapshot.empty
        ) {

            throw new AppError(
                'Blood bank manager profile already exists',
                400,
            );
        }



        // CREATE PROFILE

        const managerRef =
            bloodBankManagerCollection
                .doc();

        const bloodBankManager =
            {
                managerId:
                    managerRef.id,

                ...managerData,

                createdAt:
                    new Date().toISOString(),
            };



        await managerRef.set(
            bloodBankManager,
        );



        return bloodBankManager;
    };




// GET BLOOD BANK MANAGER

const getBloodBankManager =
    async (
        managerId,
    ) => {

        const doc =
            await bloodBankManagerCollection
                .doc(managerId)
                .get();

        if (!doc.exists) {

            throw new AppError(
                'Blood bank manager not found',
                404,
            );
        }

        return doc.data();
    };




// GET ALL BLOOD BANK MANAGERS

const getAllBloodBankManagers =
    async () => {

        const snapshot =
            await bloodBankManagerCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE BLOOD BANK MANAGER

const updateBloodBankManager =
    async (
        managerId,
        updateData,
    ) => {

        const docRef =
            bloodBankManagerCollection
                .doc(managerId);

        const doc =
            await docRef.get();

        if (!doc.exists) {

            throw new AppError(
                'Blood bank manager not found',
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




// DELETE BLOOD BANK MANAGER

const deleteBloodBankManager =
    async (
        managerId,
    ) => {

        const docRef =
            bloodBankManagerCollection
                .doc(managerId);

        const doc =
            await docRef.get();

        if (!doc.exists) {

            throw new AppError(
                'Blood bank manager not found',
                404,
            );
        }

        await docRef.delete();
    };



module.exports = {
    createBloodBankManager,
    getBloodBankManager,
    getAllBloodBankManagers,
    updateBloodBankManager,
    deleteBloodBankManager,
};