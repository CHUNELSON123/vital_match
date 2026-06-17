const express =
    require('express');

const auditTrailController =
    require(
        '../controllers/auditTrailController',
    );

const {
    verifyToken,
} = require(
    '../middlewares/authMiddleware',
);

const router =
    express.Router();

// CREATE AUDIT TRAIL

router.post(
    '/',
    verifyToken,
    auditTrailController
        .createAuditTrail,
);

// GET ALL AUDIT TRAILS

router.get(
    '/',
    verifyToken,
    auditTrailController
        .getAllAuditTrails,
);

// GET AUDIT TRAILS BY USER

router.get(
    '/user/:userId',
    verifyToken,
    auditTrailController
        .getAuditTrailsByUser,
);


router.get(
    '/hospital/:hospitalId',
    verifyToken,
    auditTrailController
        .getAuditTrailsByHospital,
);

// GET AUDIT TRAIL
router.get(
    '/:auditId',
    verifyToken,
    auditTrailController
        .getAuditTrail,
);

// UPDATE AUDIT TRAIL
router.put(
    '/:auditId',
    verifyToken,
    auditTrailController
        .updateAuditTrail,
);

// DELETE AUDIT TRAIL

router.delete(
    '/:auditId',
    verifyToken,
    auditTrailController
        .deleteAuditTrail,
);


module.exports = router;