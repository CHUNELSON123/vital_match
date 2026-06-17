const reportsService =
    require(
        '../services/reportsService',
    );

const getHospitalReports =
    async (req, res) => {

    try {

        const { hospitalId } =
            req.params;

        const report =
            await reportsService
                .getHospitalReports(
                    hospitalId,
                );

        return res.status(200)
            .json(report);

    } catch (error) {

        return res.status(500)
            .json({
                message:
                    error.message,
            });
    }
};

module.exports = {
    getHospitalReports,
};