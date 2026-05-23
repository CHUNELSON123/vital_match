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
      createdAt: doc.data().createdAt?.toDate().toISOString(),
    });

  return {
    donorId,
    ...donorData,
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


module.exports = {
  createDonorProfile,
  getDonorProfile,
  updateDonorProfile,
  updateDonorAvailability,
};