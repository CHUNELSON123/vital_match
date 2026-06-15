const rewardService =
    require(
        '../services/rewardService',
    );

const {
    validateCreateReward,
    validateUpdateReward,
} = require(
    '../validators/rewardValidator',
);




// CREATE REWARD

const createReward =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateCreateReward(
                req.body,
            );



            const reward =
                await rewardService
                    .createReward(
                        req.body,
                    );



            res.status(201).json({
                success: true,
                message:
                    'Reward created successfully',
                data: reward,
            });

        } catch (error) {
            next(error);
        }
    };




// GET ALL REWARDS

const getAllRewards =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const rewards =
                await rewardService
                    .getAllRewards();



            res.status(200).json({
                success: true,
                data: rewards,
            });

        } catch (error) {
            next(error);
        }
    };




// GET REWARD

const getReward =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const reward =
                await rewardService
                    .getReward(
                        req.params
                            .rewardId,
                    );



            res.status(200).json({
                success: true,
                data: reward,
            });

        } catch (error) {
            next(error);
        }
    };




// GET REWARDS BY DONOR

const getRewardsByDonor =
    async (
        req,
        res,
        next,
    ) => {

        try {

            const rewards =
                await rewardService
                    .getRewardsByDonor(
                        req.params
                            .donorId,
                    );



            res.status(200).json({
                success: true,
                data: rewards,
            });

        } catch (error) {
            next(error);
        }
    };




// UPDATE REWARD

const updateReward =
    async (
        req,
        res,
        next,
    ) => {

        try {

            validateUpdateReward(
                req.body,
            );



            const reward =
                await rewardService
                    .updateReward(
                        req.params
                            .rewardId,
                        req.body,
                    );



            res.status(200).json({
                success: true,
                message:
                    'Reward updated successfully',
                data: reward,
            });

        } catch (error) {
            next(error);
        }
    };




// DELETE REWARD

const deleteReward =
    async (
        req,
        res,
        next,
    ) => {

        try {

            await rewardService
                .deleteReward(
                    req.params
                        .rewardId,
                );



            res.status(200).json({
                success: true,
                message:
                    'Reward deleted successfully',
            });

        } catch (error) {
            next(error);
        }
    };


module.exports = {
    createReward,
    getAllRewards,
    getReward,
    getRewardsByDonor,
    updateReward,
    deleteReward,
};