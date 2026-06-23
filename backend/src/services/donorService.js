const { db } = require('../config/firebase');
const AppError = require('../utils/appError');

const donorsCollection = db.collection('donors');


// CREATE DONOR PROFILE

const createDonorProfile = async (donorData) => {

  const donorId = donorData.userId;

  await donorsCollection
    .doc(donorId)
    .set({
      ...donorData,
      createdAt: new Date().toISOString(),
    });

  return {
    donorId,
    ...donorData,
  };
};

const getDonor = async (
    donorId,
) => {

    const doc =
        await donorsCollection
            .doc(donorId)
            .get();

    if (!doc.exists) {
        throw new AppError(
            'Donor not found',
            404,
        );
    }

    return {
        donorId: doc.id,
        ...doc.data(),
    };
};

// GET DONOR PROFILE
const getDonorProfile = async (donorId) => {

  const donorDoc = await donorsCollection
    .doc(donorId)
    .get();

  if (!donorDoc.exists) {
    throw new AppError('Donor profile not found', 404);
  }

  return {
    donorId: donorDoc.id,
    ...donorDoc.data(),
  };
};


// UPDATE DONOR PROFILE

const updateDonorProfile = async (
  donorId,
  updateData,
) => {

  await donorsCollection
    .doc(donorId)
    .update(updateData);

  const updatedDoc = await donorsCollection
    .doc(donorId)
    .get();

  return {
    donorId: updatedDoc.id,
    ...updatedDoc.data(),
  };
};


// UPDATE DONOR AVAILABILITY

const updateDonorAvailability = async (
  donorId,
  isAvailable,
) => {

  await donorsCollection
    .doc(donorId)
    .update({
      isAvailable,
    });

  const updatedDoc = await donorsCollection
    .doc(donorId)
    .get();

  return {
    donorId: updatedDoc.id,
    ...updatedDoc.data(),
  };
};

// GET ALL DONORS

const getAllDonors = async () => {

  const snapshot =
    await donorsCollection.get();

  return snapshot.docs.map(
    (doc) => ({
      donorId: doc.id,
      ...doc.data(),
    }),
  );
};

module.exports = {
  createDonorProfile,
  getDonorProfile,
  updateDonorProfile,
  updateDonorAvailability,
  getAllDonors,
  getDonor,
};