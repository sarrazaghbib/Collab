const firebase = require('firebase');

const firebaseConfig = {
    apiKey: "AIzaSyCAzgzQBVvmAnvPVyNKby1j7zZiCzRSAVA",
    authDomain: "collabapp-1567f.firebaseapp.com",
    projectId: "collabapp-1567f",
    storageBucket: "collabapp-1567f.appspot.com",
    messagingSenderId: "826791224015",
    appId: "1:826791224015:android:980ef2006c91e7c19c4dba",
};
// Initialize Firebase
const db=firebase.initializeApp(firebaseConfig);
module.exports = db;
