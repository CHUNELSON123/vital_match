const express =
    require('express');

const labTechnicianController =
    require('../controllers/labTechnicianController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router =
    express.Router();

// CREATE LAB TECHNICIAN
router.post(
    '/',
    verifyToken,
    allowRoles(
        'hospital_admin',
    ),
    labTechnicianController
        .createLabTechnician,
);

// GET ALL LAB TECHNICIANS
router.get(
    '/',
    verifyToken,
    labTechnicianController
        .getAllLabTechnicians,
);

router.get(
    '/hospital/:hospitalId',
    verifyToken,
    allowRoles(
        'hospital_admin',
    ),
    labTechnicianController
        .getTechniciansByHospital,
);

router.get(
    '/user/:userId',
    verifyToken,
    labTechnicianController
        .getLabTechnicianByUserId,
);

// GET LAB TECHNICIAN
router.get(
    '/:technicianId',
    verifyToken,
    labTechnicianController
        .getLabTechnician,
);

// UPDATE LAB TECHNICIAN
router.put(
    '/:technicianId',
    verifyToken,
    allowRoles(
        'hospital_admin',
    ),
    labTechnicianController
        .updateLabTechnician,
);

// DELETE LAB TECHNICIAN
router.delete(
    '/:technicianId',
    verifyToken,
    allowRoles(
        'hospital_admin',
    ),
    labTechnicianController
        .deleteLabTechnician,
);

 


module.exports = router;