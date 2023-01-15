const express = require('express');
const { CreateTask,GetTasks,deleteTask } = require('../Controllers/TaskController');

const router = express.Router();
router.get('/tasks', GetTasks);
router.delete('/tasks/:owner_id', deleteTask);
router.post('/tasks',CreateTask);

module.exports = {
    routes: router
}