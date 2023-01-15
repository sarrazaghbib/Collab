'use strict';
const firebase = require('../config');

const firestore = firebase.firestore();

const CreateTask = async (req, res, next) => {
        //var user = firebase.auth().currentUser
        //if (user) {
            console.log('smthg')
            try {
              
                   await firestore.collection('Tasks').doc().set(req.body);
                    res.send("Task added ! ");
            } catch (error) {
                res.status(400).send(error.message);
            }
                    //else {
            //res.send("Acces Denied !")
        //}
}
 const GetTasks = async (req, res, next) => {
    try {
        const tasks = await firestore.collection('Tasks');
        const data = await tasks.get();
        const tasksArray = [];
        if (data.empty) {
            res.status(404).send('No active tasks ');
        } else {
            data.forEach(doc => {
                tasksArray.push(doc.data());
            });
            res.send(tasksArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
}
const deleteTask=async (req,res)=> {
    const task_id=req.params.owner_id;
    try{
        const task = firestore.collection('Tasks').doc(task_id);
        if(task){
            await task.delete();
            res.status(200).json("Task deleted !")
        }
        else{
            res.status(403).json("Task not found !")
        }
    }
    catch(e){
        res.status(403).json("Error!")
    }
}
module.exports = {
    CreateTask,GetTasks,deleteTask
}