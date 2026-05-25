const express =
    require('express');

const emergencyAlertController =
    require('../controllers/emergencyAlertController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router =
    express.Router();




// CREATE EMERGENCY ALERT

router.post(
    '/',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    emergencyAlertController
        .createEmergencyAlert,
);




// GET ALL EMERGENCY ALERTS

router.get(
    '/',
    verifyToken,
    emergencyAlertController
        .getAllEmergencyAlerts,
);




// GET EMERGENCY ALERT

router.get(
    '/:alertId',
    verifyToken,
    emergencyAlertController
        .getEmergencyAlert,
);




// UPDATE EMERGENCY ALERT

router.put(
    '/:alertId',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    emergencyAlertController
        .updateEmergencyAlert,
);




// DELETE EMERGENCY ALERT

router.delete(
    '/:alertId',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    emergencyAlertController
        .deleteEmergencyAlert,
);


module.exports = router;