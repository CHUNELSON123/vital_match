const express =
    require('express');

const donationRecordController =
    require('../controllers/donationRecordController');

const {
    verifyToken,
} = require('../middlewares/authMiddleware');

const {
    allowRoles,
} = require('../middlewares/roleMiddleware');


const router =
    express.Router();




// CREATE DONATION RECORD

router.post(
    '/',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    donationRecordController
        .createDonationRecord,
);




// GET ALL DONATION RECORDS

router.get(
    '/',
    verifyToken,
    donationRecordController
        .getAllDonationRecords,
);

router.get(
    '/hospital/:hospitalId',
    verifyToken,
    donationRecordController
        .getDonationRecordsByHospital,
);


// GET DONATION RECORD
router.get(
    '/:recordId',
    verifyToken,
    donationRecordController
        .getDonationRecord,
);




// UPDATE DONATION RECORD

router.put(
    '/:recordId',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    donationRecordController
        .updateDonationRecord,
);




// DELETE DONATION RECORD

router.delete(
    '/:recordId',
    verifyToken,
    allowRoles(
        'labTechnician',
    ),
    donationRecordController
        .deleteDonationRecord,
);


module.exports = router;