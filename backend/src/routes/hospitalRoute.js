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
    allowRoles('hospitalAdministrator'),
    hospitalController.createHospital,
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
    allowRoles('hospitalAdministrator'),
    hospitalController.updateHospital,
);


// DELETE HOSPITAL

router.delete(
    '/:hospitalId',
    verifyToken,
    allowRoles('hospitalAdministrator'),
    hospitalController.deleteHospital,
);


module.exports = router;