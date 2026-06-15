const express =
    require('express');

const healthTipController =
    require(
        '../controllers/healthTipController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);

const router =
    express.Router();




// CREATE HEALTH TIP

router.post(
    '/',
    verifyToken,
    healthTipController
        .createHealthTip,
);




// GET ALL HEALTH TIPS

router.get(
    '/',
    verifyToken,
    healthTipController
        .getAllHealthTips,
);




// GET HEALTH TIP

router.get(
    '/:tipId',
    verifyToken,
    healthTipController
        .getHealthTip,
);




// UPDATE HEALTH TIP

router.put(
    '/:tipId',
    verifyToken,
    healthTipController
        .updateHealthTip,
);




// DELETE HEALTH TIP

router.delete(
    '/:tipId',
    verifyToken,
    healthTipController
        .deleteHealthTip,
);


module.exports = router;