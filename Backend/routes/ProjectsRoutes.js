const express = require('express');
const { GetProjects,CreateProject,deleteProject,AddMemberToProject,DeleteMemberFromProject ,GetProject} = require('../Controllers/ProjectController');

const router = express.Router();
router.get('/projects/:id', GetProjects);
router.get('/project/:id', GetProject);
router.delete('/projects/:id', deleteProject);
router.post('/projects/:owner_id/:email',CreateProject);
router.put('/projects/:id',AddMemberToProject);
router.put('/deletemember/:id',DeleteMemberFromProject );


module.exports = {
    routes: router
}