const { db } = require("../config/firebase");

const allowRoles = (...allowedRoles) => {

    return async (req, res, next) => {

        try {

            //Firebase authenticated user UID
            const uid = req.user.uid;

            //Get user profile from firestore
            const userDoc = await db
                .collection("users")
                .doc(uid)
                .get();

            //Check if user exists
            if (!userDoc.exists) {
                return res.status(404).json({
                    message: "User profile not found",
                });
            }

            const userData = userDoc.data();

            const userRole = userData.role;

            //Check if role is allowed
            if (!allowedRoles.includes(userRole)) {

                return res.status(403).json({
                    message: "Access denied",
                });
            }

            //Attach role data if needed
            req.user.role = userRole;

            next();
        } catch(error){
            next(error);
        }
    };
};

module.exports = {
    allowRoles,
}