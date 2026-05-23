const express = require("express");

const {
    registerUser,
    resetPassword,

} = require("../controllers/authController");



const router = express.Router();

//Register User Route
router.post("/register", registerUser);

//Reset Password Route
router.post("/reset-password", resetPassword);

module.exports = router;