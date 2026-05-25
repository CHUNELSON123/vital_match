const express = require('express');

const bloodBankController =
    require('../controllers/bloodBankController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router = express.Router();


// CREATE BLOOD BANK

router.post(
    '/',
    verifyToken,
    allowRoles('bloodBankManager'),
    bloodBankController.createBloodBank,
);


// GET BLOOD BANK

router.get(
    '/:bloodBankId',
    verifyToken,
    bloodBankController.getBloodBank,
);


// UPDATE BLOOD BANK

router.put(
    '/:bloodBankId',
    verifyToken,
    allowRoles('bloodBankManager'),
    bloodBankController.updateBloodBank,
);


// DELETE BLOOD BANK

router.delete(
    '/:bloodBankId',
    verifyToken,
    allowRoles('bloodBankManager'),
    bloodBankController.deleteBloodBank,
);


module.exports = router;