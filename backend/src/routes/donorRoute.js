const express = require('express');

const {
  createDonorProfile,
  getDonorProfile,
  updateDonorProfile,
  updateDonorAvailability,
  getAllDonors,
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
  createDonorProfile,
);



// GET DONOR PROFILE
router.get(
  '/:donorId',
  verifyToken,
  getDonorProfile,
);


//GET ALL DONORS
router.get(
  '/',
  verifyToken,
  getAllDonors,
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