const appUserService = require("../services/appUserService");

//CREATE USER
const createUser = async (req, res, next)  => {
    try{

        const {
            fullName,
            email,
            phoneNumber,
            role,
        } = req.body;

        //USER DATA
        const userData = {
            fullName,
            email,
            phoneNumber,
            role,
        };

        //Service
        const user = await appUserService.createUser(userData);

            //RESPONSE

            res.status(201).json({
                message: "User created successfully",
                data: user,
            });
    } catch (error) {
       next(error);
    }
};

//GET USER BY ID
const getUserById = async (req, res, next) => {

    try {
        const { id } = req.params;

        const user = await appUserService.getUserById(id);

        res.status(200).json({
            data: user,
        });
    } catch (error) {
        next(error);
    }
};

//GET ALL USERS
const getAllUsers = async (req, res, next) => {

    try{
        const users = await appUserService.getAllUsers();

        res.status(200).json({
            data: users,
        });
    } catch (error) {
         next(error);
    }
};

const updateUser = async (req, res, next) => {

    try{
        const { id } = req.params;

        const updatedData = req.body;

        const updatedUser =await appUserService.updateUser(
            id,
            updatedData,
        );

        res.status(200).json({
            message: "User updated successfully",
            data: updatedUser,
        });
    } catch (error) {
       next(error);
    }
};

//Delete user
const deleteUser = async (req, res, next) => {

    try{

        const { id } = req.params;

        const result = await appUserService.deleteUser(id);

        res.status(200).json(result);
    } catch (error) {
        next(error);
    }
};

//Get current user profile
const getCurrentUser = async (req, res, next) => {

    try {

        const uid = req.user.uid;

        const user = await appUserService
            .getUserById(uid);

        res.status(200).json({
            data: user,
        });
    } catch (error) {
        next (error);
    }
};

//Update current user profile
const updateCurrentUser =  async (req, res, next) => {

    try{

        const uid = req.user.uid;

        const updatedData = req.body;

        const updatedUser = await appUserService
            .updateUser(uid, updatedData);

        res.status(200).json({
            message: "Profile updated successfully",
            data: updateUser,
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    createUser,
    getUserById,
    getAllUsers,
    updateUser,
    deleteUser,
    getCurrentUser,
    updateCurrentUser,
};