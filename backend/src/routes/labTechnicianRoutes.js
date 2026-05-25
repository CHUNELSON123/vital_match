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
        'hospitalAdministrator',
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
        'hospitalAdministrator',
    ),
    labTechnicianController
        .updateLabTechnician,
);




// DELETE LAB TECHNICIAN

router.delete(
    '/:technicianId',
    verifyToken,
    allowRoles(
        'hospitalAdministrator',
    ),
    labTechnicianController
        .deleteLabTechnician,
);


module.exports = router;