const express = require('express');
const { GetReminders,CreateReminder,deleteReminder } = require('../Controllers/ReminderController');

const router = express.Router();
router.get('/reminders/:id', GetReminders);
router.delete('/reminders/:id', deleteReminder);
router.post('/reminders/:id',CreateReminder);

module.exports = { 
    routes: router
}