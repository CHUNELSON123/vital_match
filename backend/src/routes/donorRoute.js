const express = require('express');

const {
  createDonorProfile,
  getDonorProfile,
  updateDonorProfile,
  updateDonorAvailability,
} = require('../controllers/donorController');

const {
  validateCreateDonor,
} = require('../validators/donorValidator');

const { verifyToken } = require('../middlewares/authMiddleware');

const router = express.Router();


// CREATE DONOR PROFILE

router.post(
  '/',
  verifyToken,
  validateCreateDonor,
  createDonorProfile,
);


// GET DONOR PROFILE

router.get(
  '/:donorId',
  verifyToken,
  getDonorProfile,
);


// UPDATE DONOR PROFILE

router.put(
  '/:donorId',
  verifyToken,
  updateDonorProfile,
);


// UPDATE DONOR AVAILABILITY

router.patch(
  '/:donorId',
  verifyToken,
  updateDonorAvailability,
);


module.exports = router;