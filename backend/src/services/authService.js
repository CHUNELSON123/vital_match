const { admin, db } = require("../config/firebase");
const AppError = require("../utils/appError");
const donorService = require("./donorService");
 

const registerUser = async (userData) => {

    const {
        fullName,
        email,
        password,
        phoneNumber,
        role,
        bloodGroup,
        weight,
        dateOfBirth,
        latitude,
        longitude,
    } = userData;

    const normalizedPhoneNumber =
        String(phoneNumber || '').trim();

    const existingPhoneUser = await db
        .collection("users")
        .where(
            "phoneNumber",
            "==",
            normalizedPhoneNumber,
        )
        .limit(1)
        .get();

    if (!existingPhoneUser.empty) {
        throw new AppError(
            "Phone number already exists",
            400,
        );
    }

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
        phoneNumber: normalizedPhoneNumber,
        role,
        createdAt,
    };

    //save user profile to firestore
    await db
    .collection("users")
    .doc(uid)
    .set(newUser);

if (role === "donor") {

    const birthDate = new Date(
        dateOfBirth,
    );

    const age =
        new Date().getFullYear() -
        birthDate.getFullYear();

    await donorService.createDonorProfile({
        userId: uid,
        bloodGroup,
        weight: Number(weight),
        gpsLatitude: latitude,
        gpsLongitude: longitude,
        age,
        pointsBalance: 0,
        isAvailable: true,
        isVerified: false,
        dateOfBirth,
        lastDonationDate: null,
    });
}

if (role === "hospital_admin") {

    await db
        .collection("hospital_admins")
        .doc(uid)
        .set({
            adminId: uid,
            userId: uid,
            hospitalId: null,
            adminLevel: "owner",
            createdAt,
        });
}

if (role === "lab_technician") {
    await db
        .collection("lab_technicians")
        .doc(uid)
        .set({
            technicianId: uid,
            userId: uid,
            fullName,
            email,
            phoneNumber,
            hospitalId: null,
            employeeId: null,
            department: null,
            createdAt,
        });
}

if (role === "blood_bank_manager") {
    await db
        .collection("blood_bank_managers")
        .doc(uid)
        .set({
            userId: uid,
            fullName,
            email,
            phoneNumber,
            createdAt,
        });
}
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
