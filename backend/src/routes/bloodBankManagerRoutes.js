const express =
    require('express');

const bloodBankManagerController =
    require(
        '../controllers/bloodBankManagerController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);

const {
    allowRoles,
} = require(
    '../middlewares/roleMiddleware',
);


const router =
    express.Router();




// CREATE BLOOD BANK MANAGER

router.post(
    '/',
    verifyToken,
    allowRoles(
        'blood_bank_manager',
    ),
    bloodBankManagerController
        .createBloodBankManager,
);




// GET ALL BLOOD BANK MANAGERS

router.get(
    '/',
    verifyToken,
    bloodBankManagerController
        .getAllBloodBankManagers,
);




// GET BLOOD BANK MANAGER

router.get(
    '/:managerId',
    verifyToken,
    bloodBankManagerController
        .getBloodBankManager,
);




// UPDATE BLOOD BANK MANAGER

router.put(
    '/:managerId',
    verifyToken,
    allowRoles(
        'blood_bank_manager',
    ),
    bloodBankManagerController
        .updateBloodBankManager,
);




// DELETE BLOOD BANK MANAGER

router.delete(
    '/:managerId',
    verifyToken,
    allowRoles(
        'blood_bank_manager',
    ),
    bloodBankManagerController
        .deleteBloodBankManager,
);


module.exports = router;