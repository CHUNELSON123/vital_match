const express = require("express");

const appUserController = require("../controllers/appUserController");

const {
  verifyToken,
} = require("../middlewares/authMiddleware");

const {
    allowRoles,
} = require("../middlewares/roleMiddleware");
 

const router = express.Router();

 

// GET ALL USERS
router.get("/", verifyToken, appUserController.getAllUsers);

//UPDATE CURRENT USER
router.put("/me", verifyToken, appUserController.updateCurrentUser);

//GET CURRENT USER
router.get("/me", verifyToken, appUserController.getCurrentUser);

// GET USER BY ID
router.get("/:id", verifyToken, appUserController.getUserById);

//UPDATE USER
router.put("/:id", verifyToken, appUserController.updateUser);

//DELETE USER
router.delete("/:id", verifyToken, allowRoles("hospitalAdministrator"), appUserController.deleteUser);



module.exports = router;