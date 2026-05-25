const express =
    require('express');

const alertResponseController =
    require('../controllers/alertResponseController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router =
    express.Router();




// CREATE ALERT RESPONSE

router.post(
    '/',
    verifyToken,
    allowRoles(
        'donor',
    ),
    alertResponseController
        .createAlertResponse,
);




// GET ALL ALERT RESPONSES

router.get(
    '/',
    verifyToken,
    alertResponseController
        .getAllAlertResponses,
);




// GET ALERT RESPONSE

router.get(
    '/:responseId',
    verifyToken,
    alertResponseController
        .getAlertResponse,
);




// UPDATE ALERT RESPONSE

router.put(
    '/:responseId',
    verifyToken,
    allowRoles(
        'donor',
    ),
    alertResponseController
        .updateAlertResponse,
);




// DELETE ALERT RESPONSE

router.delete(
    '/:responseId',
    verifyToken,
    allowRoles(
        'donor',
    ),
    alertResponseController
        .deleteAlertResponse,
);


module.exports = router;