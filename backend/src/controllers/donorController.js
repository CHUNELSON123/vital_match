const donorService = require('../services/donorService');

const {
    validateCreateDonor,
    validateUpdateDonor,
    validateAvailabilityUpdate,
} = require(
    '../validators/donorValidator',
);

// CREATE DONOR PROFILE

const createDonorProfile = async (req, res, next) => {

  try {

    const donorData = req.body;

    validateCreateDonor(
        donorData,
    );

    const donor = await donorService
      .createDonorProfile(donorData);

    res.status(201).json({
      success: true,
      message: 'Donor profile created successfully',
      data: donor,
    });

  } catch (error) {
    next(error);
  }
};


// GET DONOR PROFILE

const getDonorProfile = async (req, res, next) => {

  try {

    const { donorId } = req.params;

    const donor = await donorService
      .getDonorProfile(donorId);

    res.status(200).json({
      success: true,
      data: donor,
    });

  } catch (error) {
    next(error);
  }
};


// UPDATE DONOR PROFILE

const updateDonorProfile = async (req, res, next) => {

  try {

    const { donorId } = req.params;

    const updateData = req.body;

    validateUpdateDonor(
        updateData,
    );  

    const updatedDonor = await donorService
      .updateDonorProfile(
        donorId,
        updateData,
      );

    res.status(200).json({
      success: true,
      message: 'Donor profile updated successfully',
      data: updatedDonor,
    });

  } catch (error) {
    next(error);
  }
};


// UPDATE DONOR AVAILABILITY

const updateDonorAvailability = async (
  req,
  res,
  next,
) => {

  try {

    const { donorId } = req.params;

    const { isAvailable } = req.body;

    validateAvailabilityUpdate(
        req.body,
    );

    const updatedDonor = await donorService
      .updateDonorAvailability(
        donorId,
        isAvailable,
      );

    res.status(200).json({
      success: true,
      message: 'Donor availability updated successfully',
      data: updatedDonor,
    });

  } catch (error) {
    next(error);
  }
};


module.exports = {
  createDonorProfile,
  getDonorProfile,
  updateDonorProfile,
  updateDonorAvailability,
};