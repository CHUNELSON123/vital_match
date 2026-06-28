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

// AUDIT TRAILS
const auditTrailSnapshot =
    await db
        .collection(
            'audit_trails',
        )
        .where(
            'hospitalId',
            '==',
            hospitalId,
        )
        .get();


const donationTrendMap = {};

const bloodDistributionMap = {};

let totalBloodUnits = 0;

bloodUnitsSnapshot.docs.forEach(
    (doc) => {
        const data = doc.data();
        const quantity =
            Number(data.quantity || 0);
        const bloodType =
            data.bloodType ||
            data.bloodGroup;

        totalBloodUnits += quantity;

        if (bloodType) {
            bloodDistributionMap[
                bloodType
            ] =
                (
                    bloodDistributionMap[
                        bloodType
                    ] || 0
                ) + quantity;
        }
    },
);

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
        totalBloodUnits,

    totalDonationRecords:
        donationRecordsSnapshot.size,

    totalTechnicians:
        techniciansSnapshot.size,

   recentActivity:
    auditTrailSnapshot.size,

    donationTrend:
        Object.entries(
            donationTrendMap,
        ).map(
            ([month, total]) => ({
                month,
                total,
            }),
        ),

   bloodDistribution:
    Object.entries(
        bloodDistributionMap,
    ).map(
        ([bloodType, total]) => ({
            bloodType,
            total,
        }),
    ),
};
};

module.exports = {
    getHospitalReports,
};
