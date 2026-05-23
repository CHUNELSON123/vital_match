const { db } = require("../config/firebase");
const AppError = require("../utils/appError");
const {
    validateCreateUser,
    validateUpdateUser,
} = require("../validators/authValidator");

// CREATE USER SERVICE
const createUser = async (userData) => {

    //validate user data
    validateCreateUser(userData);

    //Check if email already exists
    const existingUserSnapshot = await db
        .collection("users")
        .where("email", "==", userData.email)
        .get();

    if (!existingUserSnapshot.empty) {
        throw new AppError("Email already exists", 409);
    }

    // SAVE TO FIRESTORE
    const userRef = await db
        .collection("users")
        .add({
            ...userData,
            createdAt: new Date(),
        });

    // GENERATED ID
    const generatedId = userRef.id;

    // UPDATE DOCUMENT WITH ID
    await userRef.update({
        userId: generatedId,
    });

    // FINAL USER DATA
    return {
        userId: generatedId,
        ...userData,
        createdAt: new Date(),
    };
};

//GET USER BY ID
const getUserById = async (userId) => {

     
    const userDoc = await db 
        .collection("users")
        .doc(userId)
        .get();

    //check is user exist
    if(!userDoc.exists) {
        throw new AppError("User not found", 404);
    }

    const userData = userDoc.data();

    return {
        ...userData,

        createdAt: userData.createdAt?.toDate(),
    };
};

//Get all user
const getAllUsers = async() => {

    const usersSnapshot = await db
        .collection("users")
        .get();

    const users = usersSnapshot.docs.map((doc) => {

        const userData = doc.data();

        return {
            ...userData,
            createdAt: userData.createdAt?.toDate(),
        };
    });

    return users;
};

//Update user
const updateUser = async (userId, updatedData) => {

    //Validate user updated data
    validateUpdateUser(updatedData);

    const userRef = db  
        .collection("users")
        .doc(userId);

    //Check if user exist
    const userDoc = await userRef.get();

    if(!userDoc.exists){
        throw new AppError("User not found", 404);
    }

    //Allowed updated fields
    const allowedFields = [
        "fullName",
        "email",
        "phoneNumber",
        "role",
    ];

    //Get provided fields
    const providedFields = Object.keys(updatedData);

    //Check for invalid fields
    const invalidFields = providedFields.filter(
        (field) => !allowedFields.includes(field)
    );

    if(invalidFields.length > 0) {
        throw new AppError(`Invalid update fields: ${invalidFields.join(", ")}`, 400);
    }

    //Update user
    await userRef.update(updatedData);

    //Get updated user
    const updatedUserDoc = await userRef.get();

    const userData = updatedUserDoc.data();

    return {
        ...userData,
        createdAt: userData.createdAt?.toDate(),
    };
};

//Delete user
const deleteUser = async (userId) => {

    const userRef = db
        .collection("users")
        .doc(userId);

    //Check if the user exists
    const userDoc = await userRef.get();

    if(!userDoc.exists){
        throw new AppError("User not found", 404);
    }

    //Delete user
    await userRef.delete();

    return {
        message: "User deleted successfully",
    };
};

module.exports = {
    createUser,
    getUserById,
    getAllUsers,
    updateUser,
    deleteUser,
};