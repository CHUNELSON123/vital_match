const express = require("express");
const cors = require("cors");
 const errorHandler = require("./middlewares/errorHandler");
const appUserRoutes = require("./routes/appUserRoutes");
const authRoutes = require("./routes/authRoutes");
const donorRoutes = require("./routes/donorRoute");
const hospitalRoutes = require("./routes/hospitalRoute");
const bloodBankRoutes = require("./routes/bloodBankRoute");
const bloodUnitRoutes = require("./routes/bloodUnitRoute");
const donationRecordRoutes = require("./routes/donationRecordRoutes");
const labTechnicianRoutes = require("./routes/labTechnicianRoutes");
const hospitalAdminRoutes = require("./routes/hospitalAdminRoutes");
const bloodBankManagerRoutes = require("./routes/bloodBankManagerRoutes");
const emergencyAlertRoutes= require("./routes/emergencyAlertRoutes");
const alertResponseRoutes = require("./routes/alertResponseRoutes",);
const transferOrderRoutes = require("./routes/transferOrderRoutes",);
const donationCampaignRoutes = require("./routes/donationCampaignRoutes");
const notificationRoutes = require("./routes/notificationRoutes");
const rewardRoutes = require("./routes/rewardRoutes");
const healthTipRoutes = require('./routes/healthTipRoutes',);
const auditTrailRoutes = require('./routes/auditTrailRoutes',);

const app = express();

//MIDDLEWARE
app.use(cors());

app.use(express.json());

// ROUTES
app.use('/api/auth', authRoutes);
app.use('/api/users', appUserRoutes);
app.use('/api/donors', donorRoutes);
app.use('/api/hospitals', hospitalRoutes);
app.use('/api/blood-banks', bloodBankRoutes);
app.use('/api/blood-units', bloodUnitRoutes,);
app.use('/api/donation-records', donationRecordRoutes);
app.use('/api/lab-technicians', labTechnicianRoutes);
app.use('/api/hospital-admins', hospitalAdminRoutes);
app.use('/api/blood-bank-managers', bloodBankManagerRoutes);
app.use('/api/emergency-alerts', emergencyAlertRoutes);
app.use('/api/alert-responses', alertResponseRoutes,);
app.use('/api/transfer-orders', transferOrderRoutes,);
app.use('/api/donation-campaigns', donationCampaignRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/rewards', rewardRoutes);
app.use('/api/health-tips', healthTipRoutes,);
app.use('/api/audit-trails', auditTrailRoutes,);

app.use(errorHandler);

//EXPORT APP
module.exports = app;