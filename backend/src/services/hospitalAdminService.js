const { db } =
    require('../config/firebase');

const AppError =
    require('../utils/appError');



const hospitalAdminCollection =
    db.collection(
        'hospital_admins',
    );

const userCollection =
    db.collection('users');

const hospitalCollection =
    db.collection('hospitals');




// CREATE HOSPITAL ADMIN

const createHospitalAdmin =
    async (
        adminData,
    ) => {

        // VALIDATE USER

        const userDoc =
            await userCollection
                .doc(
                    adminData.userId,
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
            'hospital_admin'
        ) {
            throw new AppError(
                'User is not a hospital administrator',
                400,
            );
        }



        // VALIDATE HOSPITAL

        const hospitalDoc =
            await hospitalCollection
                .doc(
                    adminData.hospitalId,
                )
                .get();

        if (!hospitalDoc.exists) {
            throw new AppError(
                'Hospital not found',
                404,
            );
        }



        // CHECK IF PROFILE EXISTS

        const existingSnapshot =
            await hospitalAdminCollection
                .where(
                    'userId',
                    '==',
                    adminData.userId,
                )
                .get();

        if (
            !existingSnapshot.empty
        ) {
            throw new AppError(
                'Hospital admin profile already exists',
                400,
            );
        }



        // CREATE PROFILE

        const adminRef =
            hospitalAdminCollection
                .doc();

        const hospitalAdmin = {
            adminId:
                adminRef.id,

            ...adminData,

            createdAt:
                new Date().toISOString(),
        };

        await adminRef.set(
            hospitalAdmin,
        );

        return hospitalAdmin;
    };




// GET HOSPITAL ADMIN

const getHospitalAdmin =
    async (
        adminId,
    ) => {

        const doc =
            await hospitalAdminCollection
                .doc(adminId)
                .get();

        if (!doc.exists) {
            throw new AppError(
                'Hospital admin not found',
                404,
            );
        }

        return doc.data();
    };




// GET ALL HOSPITAL ADMINS

const getAllHospitalAdmins =
    async () => {

        const snapshot =
            await hospitalAdminCollection
                .get();

        return snapshot.docs.map(
            (doc) => doc.data(),
        );
    };




// UPDATE HOSPITAL ADMIN

const updateHospitalAdmin =
    async (
        adminId,
        updateData,
    ) => {

        const docRef =
            hospitalAdminCollection
                .doc(adminId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Hospital admin not found',
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




// DELETE HOSPITAL ADMIN

const deleteHospitalAdmin =
    async (
        adminId,
    ) => {

        const docRef =
            hospitalAdminCollection
                .doc(adminId);

        const doc =
            await docRef.get();

        if (!doc.exists) {
            throw new AppError(
                'Hospital admin not found',
                404,
            );
        }

        await docRef.delete();
    };


module.exports = {
    createHospitalAdmin,
    getHospitalAdmin,
    getAllHospitalAdmins,
    updateHospitalAdmin,
    deleteHospitalAdmin,
};