const { db } = require('../config/firebase');

const AppError = require('../utils/appError');

const {
    validateCreateHospital,
    validateUpdateHospital,
} = require('../validators/hospitalValidator');


const hospitalCollection = 'hospitals';

const normalizePhoneNumber = (value) =>
    String(value || '')
        .trim()
        .replace(/\s+/g, '')
        .replace(/^\+237/, '');


// CREATE HOSPITAL

const createHospital = async (data, ownerId,) => {
console.log('CREATE HOSPITAL SERVICE HIT');
    validateCreateHospital(data);

    const normalizedContactNumber =
        normalizePhoneNumber(data.contactNumber);

    const existingUserPhone = await db
        .collection('users')
        .where(
            'phoneNumber',
            '==',
            normalizedContactNumber,
        )
        .limit(1)
        .get();

    if (!existingUserPhone.empty) {
        throw new AppError(
            'Phone number already exists',
            400,
        );
    }

    const existingHospitalPhone = await db
        .collection(hospitalCollection)
        .where(
            'contactNumber',
            '==',
            normalizedContactNumber,
        )
        .limit(1)
        .get();

    if (!existingHospitalPhone.empty) {
        throw new AppError(
            'Contact number already exists',
            400,
        );
    }

    const hospitalRef = db
        .collection(hospitalCollection)
        .doc();

    const hospital = {
        hospitalId: hospitalRef.id,
        ownerId: ownerId,
        name: data.name,
        address: data.address,
        contactNumber: normalizedContactNumber,
        latitude: data.latitude,
        longitude: data.longitude,
        geofenceRadiusKm: data.geofenceRadiusKm,
        createdAt: new Date(),
    };

    await hospitalRef.set(hospital);

     console.log(
    'OWNER ID:',
    ownerId,
);

const adminDoc = await db
    .collection('hospital_admins')
    .doc(ownerId)
    .get();

const allAdmins = await db
    .collection('hospital_admins')
    .get();

console.log(
    'ALL ADMIN DOC IDS:',
    allAdmins.docs.map(
        doc => doc.id,
    ),
);

console.log(
    'ADMIN EXISTS:',
    adminDoc.exists,
);

if (adminDoc.exists) {
    console.log(
        'ADMIN DATA:',
        adminDoc.data(),
    );
}

    if (!adminDoc.exists) {
        throw new AppError(
            "Hospital admin profile not found",
            404,
        );
    }

    await db
    .collection("hospital_admins")
    .doc(ownerId)
    .update({
        hospitalId: hospitalRef.id,
    });

    const updatedAdmin = await db
    .collection('hospital_admins')
    .doc(ownerId)
    .get();

console.log(
    'UPDATED ADMIN:',
    updatedAdmin.data(),
);
    
    return hospital;
};


// GET HOSPITAL

const getHospital = async (hospitalId) => {

    const hospitalDoc = await db
        .collection(hospitalCollection)
        .doc(hospitalId)
        .get();

    if (!hospitalDoc.exists) {
        throw new AppError(
            'Hospital not found',
            404,
        );
    }

    return hospitalDoc.data();
};


// UPDATE HOSPITAL

const updateHospital = async (
    hospitalId,
    data,
) => {

    validateUpdateHospital(data);

    if (data.contactNumber !== undefined) {
        const normalizedContactNumber =
            normalizePhoneNumber(data.contactNumber);

        const existingUserPhone = await db
            .collection('users')
            .where(
                'phoneNumber',
                '==',
                normalizedContactNumber,
            )
            .limit(1)
            .get();

        if (!existingUserPhone.empty) {
            throw new AppError(
                'Phone number already exists',
                400,
            );
        }

        data.contactNumber = normalizedContactNumber;
    }

    const hospitalRef = db
        .collection(hospitalCollection)
        .doc(hospitalId);

    const hospitalDoc = await hospitalRef.get();

    if (!hospitalDoc.exists) {
        throw new AppError(
            'Hospital not found',
            404,
        );
    }

    await hospitalRef.update(data);

    return {
        hospitalId,
        ...data,
    };
};


// DELETE HOSPITAL

const deleteHospital = async (
    hospitalId,
) => {

    const hospitalRef = db
        .collection(hospitalCollection)
        .doc(hospitalId);

    const hospitalDoc = await hospitalRef.get();

    if (!hospitalDoc.exists) {
        throw new AppError(
            'Hospital not found',
            404,
        );
    }

    await hospitalRef.delete();
};

const getHospitalByOwnerId =
    async (
        ownerId,
    ) => {

        const snapshot =
            await db
                .collection(
                    hospitalCollection,
                )
                .where(
                    'ownerId',
                    '==',
                    ownerId,
                )
                .limit(1)
                .get();

        if (
            snapshot.empty
        ) {
            throw new AppError(
                'Hospital not found',
                404,
            );
        }

        const hospitalDoc =
            snapshot.docs[0];

        return {
            hospitalId:
                hospitalDoc.id,
            ...hospitalDoc.data(),
        };
    };


module.exports = {
    createHospital,
    getHospital,
    updateHospital,
    deleteHospital,
    getHospitalByOwnerId,
};
