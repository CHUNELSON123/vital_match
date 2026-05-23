const express = require("express");
const cors = require("cors");
 const errorHandler = require("./middlewares/errorHandler");
const appUserRoutes = require("./routes/appUserRoutes");
const authRoutes = require("./routes/authRoutes");
const donorRoutes = require("./routes/donorRoute");
const hospitalRoutes = require("./routes/hospitalRoute");

const app = express();

//MIDDLEWARE
app.use(cors());

app.use(express.json());

// ROUTES
app.use('/api/auth', authRoutes);
app.use('/api/users', appUserRoutes);
app.use('/api/donors', donorRoutes);
app.use('/api/hospitals', hospitalRoutes);

app.use(errorHandler);

//EXPORT APP
module.exports = app;