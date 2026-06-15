const { db } =
    require('../config/firebase');


const transferOrderCollection =
    db.collection(
        'transfer_orders',
    );

const hospitalCollection =
    db.collection(
        'hospitals',
    );

const bloodBankCollection =
    db.collection(
        'blood_banks',
    );

const userCollection =
    db.collection('users');




// CREATE TRANSFER ORDER

const createTransferOrder =
    async (
        transferOrderData,
    ) => {

        // VALIDATE HOSPITAL

        const hospitalDoc =
            await hospitalCollection
                .doc(
                    transferOrderData
                        .hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new Error(
                'Hospital not found',
            );
        }



        // VALIDATE BLOOD BANK

        const bloodBankDoc =
            await bloodBankCollection
                .doc(
                    transferOrderData
                        .bloodBankId,
                )
                .get();

        if (!bloodBankDoc.exists) {
            throw new Error(
                'Blood bank not found',
            );
        }



        // VALIDATE MANAGER

        const managerDoc =
            await userCollection
                .doc(
                    transferOrderData
                        .managerId,
                )
                .get();

        if (!managerDoc.exists) {
            throw new Error(
                'Blood bank manager not found',
            );
        }

        const managerData =
            managerDoc.data();

        if (
            managerData.role !==
            'bloodBankManager'
        ) {
            throw new Error(
                'User is not a blood bank manager',
            );
        }



        // CREATE TRANSFER ORDER

        const transferOrderRef =
            transferOrderCollection
                .doc();

        const transferOrder = {
            orderId:
                transferOrderRef.id,

            ...transferOrderData,
        };

        await transferOrderRef.set(
            transferOrder,
        );

        return transferOrder;
    };




// GET TRANSFER ORDER

const getTransferOrder =
    async (orderId) => {

        const doc =
            await transferOrderCollection
                .doc(orderId)
                .get();

        if (!doc.exists) {
            throw new Error(
                'Transfer order not found',
            );
        }

        return doc.data();
    };




// GET ALL TRANSFER ORDERS

const getAllTransferOrders =
    async () => {

        const snapshot =
            await transferOrderCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE TRANSFER ORDER

const updateTransferOrder =
    async (
        orderId,
        updateData,
    ) => {

        const docRef =
            transferOrderCollection
                .doc(orderId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Transfer order not found',
            );
        }

        await docRef.update(
            updateData,
        );

        const updatedDoc =
            await docRef.get();

        return updatedDoc.data();
    };




// DELETE TRANSFER ORDER

const deleteTransferOrder =
    async (orderId) => {

        const docRef =
            transferOrderCollection
                .doc(orderId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new Error(
                'Transfer order not found',
            );
        }

        await docRef.delete();
    };


module.exports = {
    createTransferOrder,
    getTransferOrder,
    getAllTransferOrders,
    updateTransferOrder,
    deleteTransferOrder,
};