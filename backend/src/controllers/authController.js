const authService = require("../services/authService");
const { db } = require("../config/firebase");

//Register user
const registerUser = async (req, res, next) => {

    try{

        const user = await authService.registerUser(req.body);

        res.status(201).json({
            message: "User registered successfully",
            data: user,
        });
    } catch(error){
        next(error);
    }
};

//Reset Password
const resetPassword =  async (req, res, next) => {

    try {

         console.log("RESET PASSWORD HIT");

        console.log(req.body);

        const { email } = req.body;

        console.log(email);

        const result = await authService
            .resetPassword(email);

        res.status(200).json(result);

    }catch (error){
        next(error);
    }
};

const getUserProfile = async (req, res, next) => {
    try {
        const { uid } = req.params;

        const userDoc = await db
            .collection("users")
            .doc(uid)
            .get();

        if (!userDoc.exists) {
            return res.status(404).json({
                message: "User not found",
            });
        }

        res.status(200).json(userDoc.data());

    } catch (error) {
        next(error);
    }
};

module.exports = {
    getUserProfile,
    registerUser,
    resetPassword,
};