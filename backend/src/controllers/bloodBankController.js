const bloodBankService =
    require('../services/bloodBankService');

const {
    validateCreateBloodBank,
    validateUpdateBloodBank,
} = require('../validators/bloodBankValidator');



// CREATE BLOOD BANK

const createBloodBank = async (
    req,
    res,
    next,
) => {

    try {

        validateCreateBloodBank(
            req.body,
        );

        const bloodBank =
            await bloodBankService
                .createBloodBank(
                    req.body,
                );

        res.status(201).json({
            success: true,
            message:
                'Blood bank created successfully',
            data: bloodBank,
        });

    } catch (error) {
        next(error);
    }
};



// GET BLOOD BANK

const getBloodBank = async (
    req,
    res,
    next,
) => {

    try {

        const bloodBank =
            await bloodBankService
                .getBloodBank(
                    req.params
                        .bloodBankId,
                );

        res.status(200).json({
            success: true,
            data: bloodBank,
        });

    } catch (error) {
        next(error);
    }
};



// UPDATE BLOOD BANK

const updateBloodBank = async (
    req,
    res,
    next,
) => {

    try {

        validateUpdateBloodBank(
            req.body,
        );

        const updatedBloodBank =
            await bloodBankService
                .updateBloodBank(
                    req.params
                        .bloodBankId,
                    req.body,
                );

        res.status(200).json({
            success: true,
            message:
                'Blood bank updated successfully',
            data: updatedBloodBank,
        });

    } catch (error) {
        next(error);
    }
};



// DELETE BLOOD BANK

const deleteBloodBank = async (
    req,
    res,
    next,
) => {

    try {

        await bloodBankService
            .deleteBloodBank(
                req.params
                    .bloodBankId,
            );

        res.status(200).json({
            success: true,
            message:
                'Blood bank deleted successfully',
        });

    } catch (error) {
        next(error);
    }
};


module.exports = {
    createBloodBank,
    getBloodBank,
    updateBloodBank,
    deleteBloodBank,
};