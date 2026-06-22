const express = require('express');

const hospitalController =
    require('../controllers/hospitalController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router = express.Router();


// CREATE HOSPITAL

router.post(
    '/',
    verifyToken,
    allowRoles('hospital_admin'),
    hospitalController.createHospital,
);


router.get(
    '/owner/:ownerId',
    verifyToken,
    hospitalController.getHospitalByOwnerId,
);

// GET HOSPITAL

router.get(
    '/:hospitalId',
    verifyToken,
    hospitalController.getHospital,
);


// UPDATE HOSPITAL

router.put(
    '/:hospitalId',
    verifyToken,
    allowRoles('hospital_admin'),
    hospitalController.updateHospital,
);


// DELETE HOSPITAL

router.delete(
    '/:hospitalId',
    verifyToken,
    allowRoles('hospital_admin'),
    hospitalController.deleteHospital,
);


module.exports = router;