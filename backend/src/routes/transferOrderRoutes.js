const express =
    require('express');

const transferOrderController =
    require('../controllers/transferOrderController');

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




// CREATE TRANSFER ORDER

router.post(
    '/',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    transferOrderController
        .createTransferOrder,
);




// GET ALL TRANSFER ORDERS

router.get(
    '/',
    verifyToken,
    transferOrderController
        .getAllTransferOrders,
);




// GET TRANSFER ORDER

router.get(
    '/:orderId',
    verifyToken,
    transferOrderController
        .getTransferOrder,
);




// UPDATE TRANSFER ORDER

router.put(
    '/:orderId',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    transferOrderController
        .updateTransferOrder,
);




// DELETE TRANSFER ORDER

router.delete(
    '/:orderId',
    verifyToken,
    allowRoles(
        'bloodBankManager',
    ),
    transferOrderController
        .deleteTransferOrder,
);


module.exports = router;