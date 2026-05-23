const authService = require("../services/authService");

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

module.exports = {
    registerUser,
    resetPassword,
};