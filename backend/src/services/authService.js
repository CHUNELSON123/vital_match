const { admin, db } = require("../config/firebase");
const AppError = require("../utils/appError");

const registerUser = async (userData) => {

    const {
        fullName,
        email,
        password,
        phoneNumber,
        role,
    } = userData;

    //Create firebase auth user
    const userRecord = await admin.auth().createUser({
        email,
        password,
    });

    //Firebase auth uid
    const uid = userRecord.uid;

    //User profile data
    const createdAt = new Date();

    const newUser = {
        userId: uid,
        fullName,
        email,
        phoneNumber,
        role,
        createdAt,
    };

    //save user profile to firestore
    await db
        .collection("users")
        .doc(uid)
        .set(newUser);

    return newUser;
};

//Reset Password
const resetPassword = async (email) => {

    //Generate password reset link
    const resetLink = await admin
        .auth()
        .generatePasswordResetLink(email);

    return {
        message: "Password reset link generated successfully",
        resetLink,
    };
};

module.exports = {
    registerUser,
    resetPassword,
};