const { admin } = require("../config/firebase");
const AppError = require("../utils/appError");

const verifyToken = async (req, res, next) => {

    try{

        //Get authorization header
        const authHeader = req.headers.authorization;

         

        //Check if token exists
        if(
            !authHeader || 
            !authHeader.startsWith("Bearer ")
        ) {
            throw new AppError(
                "Unauthorized: No token provided",
                401
            );
        }

        //Exract token
        const token = authHeader.split(" ")[1];

        //Verify token
        const decodedToken =await admin
            .auth()
            .verifyIdToken(token);

        //Attach user to request
        req.user = decodedToken;

        next();
    } catch (error){
        next(
        new AppError("Unauthorized", 401)
    );
    }
};

module.exports = {
    verifyToken,
};