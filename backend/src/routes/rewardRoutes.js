const express =
    require('express');

const rewardController =
    require(
        '../controllers/rewardController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);


const router =
    express.Router();




// CREATE REWARD

router.post(
    '/',
    verifyToken,
    rewardController
        .createReward,
);




// GET ALL REWARDS

router.get(
    '/',
    verifyToken,
    rewardController
        .getAllRewards,
);




// GET REWARDS BY DONOR

router.get(
    '/donor/:donorId',
    verifyToken,
    rewardController
        .getRewardsByDonor,
);




// GET REWARD

router.get(
    '/:rewardId',
    verifyToken,
    rewardController
        .getReward,
);




// UPDATE REWARD

router.put(
    '/:rewardId',
    verifyToken,
    rewardController
        .updateReward,
);




// DELETE REWARD

router.delete(
    '/:rewardId',
    verifyToken,
    rewardController
        .deleteReward,
);


module.exports = router;