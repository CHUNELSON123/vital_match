const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");

admin.initializeApp();

const app = express();

app.use(express.json());

// =========================
// TEST ROUTE
// =========================

app.get("/", (req, res) => {
  res.send("Vital Match API Running...");
});

// =========================
// EXPORT API
// =========================

exports.api = functions.https.onRequest(app);
