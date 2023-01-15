'use strict';
const express = require('express');
const cors = require('cors');


const bodyParser = require('body-parser');

const app = express();

const port = process.env.PORT || 5000;



app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

//Project
const ProjectsRoutes = require('./routes/ProjectsRoutes');
app.use('/api', ProjectsRoutes.routes);
//Task 
const TasksRoutes = require('./routes/TasksRoutes');
app.use('/api', TasksRoutes.routes);
//Reminder
const RemindersRoutes = require('./routes/RemindersRoutes');
app.use('/api', RemindersRoutes.routes);
//Member
//const MembersRoutes = require('./routes/MembersRoutes');
//app.use('/api', MembersRoutes.routes);




app.listen(port, () => console.log('App is listening on url http://localhost:' + port));

