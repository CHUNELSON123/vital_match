const { db } =
    require('../config/firebase');

const getHospitalReports =
    async (hospitalId) => {

    // BLOOD UNITS

    const bloodUnitsSnapshot =
        await db
            .collection(
                'blood_units',
            )
            .where(
                'hospitalId',
                '==',
                hospitalId,
            )
            .get();

    // DONATION RECORDS

    const donationRecordsSnapshot =
        await db
            .collection(
                'donation_records',
            )
            .where(
                'hospitalId',
                '==',
                hospitalId,
            )
            .get();

    // TECHNICIANS

    const techniciansSnapshot =
        await db
            .collection(
                'lab_technicians',
            )
            .where(
                'hospitalId',
                '==',
                hospitalId,
            )
            .get();


const donationTrendMap = {};

donationRecordsSnapshot.docs.forEach(
    (doc) => {

    const data = doc.data();

    if (!data.donationDate) {
        return;
    }

    const date =
        new Date(
            data.donationDate,
        );

    const month =
        date.toLocaleString(
            'default',
            {
                month: 'short',
            },
        ).toUpperCase();

    donationTrendMap[month] =
        (donationTrendMap[month] || 0)
        + 1;
});

   return {

    totalBloodUnits:
        bloodUnitsSnapshot.size,

    totalDonationRecords:
        donationRecordsSnapshot.size,

    totalTechnicians:
        techniciansSnapshot.size,

    recentActivity: 0,

    donationTrend:
        Object.entries(
            donationTrendMap,
        ).map(
            ([month, total]) => ({
                month,
                total,
            }),
        ),

    bloodDistribution: [],
};
};

module.exports = {
    getHospitalReports,
};