const { db } = require('../config/firebase');

const AppError = require('../utils/appError');

const {
    validateCreateHospital,
    validateUpdateHospital,
} = require('../validators/hospitalValidator');


const hospitalCollection = 'hospitals';


// CREATE HOSPITAL

const createHospital = async (data) => {

    validateCreateHospital(data);

    const hospitalRef = db
        .collection(hospitalCollection)
        .doc();

    const hospital = {
        hospitalId: hospitalRef.id,
        name: data.name,
        address: data.address,
        contactNumber: data.contactNumber,
        latitude: data.latitude,
        longitude: data.longitude,
        geofenceRadiusKm: data.geofenceRadiusKm,
        createdAt: new Date(),
    };

    await hospitalRef.set(hospital);

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


module.exports = {
    createHospital,
    getHospital,
    updateHospital,
    deleteHospital,
};