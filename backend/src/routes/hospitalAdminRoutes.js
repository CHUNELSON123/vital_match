const express =
    require('express');

const hospitalAdminController =
    require('../controllers/hospitalAdminController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router =
    express.Router();




// CREATE HOSPITAL ADMIN

router.post(
    '/',
    verifyToken,
    allowRoles(
        'hospitalAdministrator',
    ),
    hospitalAdminController
        .createHospitalAdmin,
);




// GET ALL HOSPITAL ADMINS

router.get(
    '/',
    verifyToken,
    hospitalAdminController
        .getAllHospitalAdmins,
);




// GET HOSPITAL ADMIN

router.get(
    '/:adminId',
    verifyToken,
    hospitalAdminController
        .getHospitalAdmin,
);




// UPDATE HOSPITAL ADMIN

router.put(
    '/:adminId',
    verifyToken,
    allowRoles(
        'hospitalAdministrator',
    ),
    hospitalAdminController
        .updateHospitalAdmin,
);




// DELETE HOSPITAL ADMIN

router.delete(
    '/:adminId',
    verifyToken,
    allowRoles(
        'hospitalAdministrator',
    ),
    hospitalAdminController
        .deleteHospitalAdmin,
);


module.exports = router;