const admin = require("firebase-admin");

const serviceAccount = require("../../serviceAccountKey.json");

//INITIALIZE FIREBASE ADMIN
admin.initializeApp({
    credential: admin.credential.cert(
        serviceAccount
    ),
});

//FIRESTORE DATABASE
const db = admin.firestore();

module.exports = {
    admin,
    db,
};