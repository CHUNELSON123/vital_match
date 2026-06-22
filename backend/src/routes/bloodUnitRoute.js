const express = require('express');

const bloodUnitController =
    require('../controllers/bloodUnitController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router = express.Router();



// CREATE BLOOD UNIT

router.post(
    '/',
    verifyToken,
    allowRoles(
        'labTechnician',
        'bloodBankManager',
    ),
    bloodUnitController
        .createBloodUnit,
);

//GET Blood unit by hospital
router.get(
    '/hospital/:hospitalId',
    verifyToken,
    bloodUnitController
        .getBloodUnitsByHospital,
);

// GET BLOOD UNIT
router.get(
    '/:bloodUnitId',
    verifyToken,
    bloodUnitController
        .getBloodUnit,
);



// UPDATE BLOOD UNIT

router.put(
    '/:bloodUnitId',
    verifyToken,
    allowRoles(
        'labTechnician',
        'bloodBankManager',
    ),
    bloodUnitController
        .updateBloodUnit,
);

router.get(
    '/',
    verifyToken,
    bloodUnitController
        .getAllBloodUnits,
);

// DELETE BLOOD UNIT

router.delete(
    '/:bloodUnitId',
    verifyToken,
    allowRoles(
        'labTechnician',
        'bloodBankManager',
    ),
    bloodUnitController
        .deleteBloodUnit,
);


module.exports = router;