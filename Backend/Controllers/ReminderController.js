'use strict';
const firebase = require('../config');

const firestore = firebase.firestore();

const CreateReminder = async (req, res, next) => {
        //var user = firebase.auth().currentUser
        //if (user) {
            try {
                    var jsonfile={
                        "project_id":req.params.id,
                        "text":req.body.text,
                    }
                    await firestore.collection('reminders').doc().set(jsonfile);
                    res.send("reminders added ! ");
            } catch (error) {
                res.status(400).send(error.message);
            }
                    //else {
            //res.send("Acces Denied !")
        //}
}
 const GetReminders = async (req, res, next) => {
    try {
        const reminders = await firestore.collection('reminders');
        const data = await reminders.where("project_id",'==',req.params.id).get();
        const remindersArray = [];
        if (data.empty) {
            res.status(404).send('No Reminders record found');
        } else {
            data.forEach(doc => {
                var reminder=new Object();
                reminder["id"]=doc.id;
                reminder["text"]=doc.data().text,
                reminder["project_id"]=doc.data().project_id;
                remindersArray.push(reminder);
            });
            res.send(remindersArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
}
const deleteReminder=async (req,res)=> {
    const Reminders_id=req.params.id;
    try{
        const Reminders = firestore.collection('reminders').doc(Reminders_id);
        if(Reminders){
            await Reminders.delete();
            res.status(200).json("Reminders deleted !")
        }
        else{
            res.status(403).json("Reminders not found !")
        }
    }
    catch(e){
        res.status(403).json("Error!")
    }
}
module.exports = {
    CreateReminder,GetReminders,deleteReminder
}