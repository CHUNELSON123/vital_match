const express =
    require('express');

const router =
    express.Router();

const reportsController =
    require(
        '../controllers/reportsController',
    );

router.get(
    '/hospital/:hospitalId',
    reportsController
        .getHospitalReports,
);

module.exports = router;