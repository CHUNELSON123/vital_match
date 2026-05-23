const express = require("express");
const cors = require("cors");
 const errorHandler = require("./middlewares/errorHandler");
const appUserRoutes = require("./routes/appUserRoutes");
const authRoutes = require("./routes/authRoutes");

const app = express();

//MIDDLEWARE
app.use(cors());

app.use(express.json());



//ROUTES
app.use("/api/users", appUserRoutes);

//Error handler
app.use(errorHandler);

//Auth routes
app.use("/api/auth", authRoutes);

//TEST ROUTE
app.get("/", (req, res) => {
    res.json({
        message: "Vital Match Api Running...",
    });
});

//EXPORT APP
module.exports = app;