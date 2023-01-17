'use strict';
const firebase = require('../config');

const firestore = firebase.firestore();

const CreateProject = async (req, res, next) => {
    var array=[];
    array[0]=req.params.email;
            try {
                    var project={
                        "owner_id":req.params.owner_id,
                        "title":req.body.title,
                        "description":req.body.description,
                        "members":array,
                        "start_date":req.body.start_date,
                        "end_date":req.body.end_date,
                    }
                    console.log(project)
                    await firestore.collection('projects').doc().set(project);
                    res.status(200).send("projects added ! ");
            } catch (error) {
                res.status(400).send(error.message);
            }
}
const AddMemberToProject = async (req, res, next) => {
    var array=[];
            try {
                    var project = await firestore.collection('projects').doc(req.params.id);
                    const data = await project.get();
                    array=data.data().members
                    const x =array.indexOf(req.body.member,0)
                    console.log(x);
                    if (x<0){
                        array.push(req.body.member)
                        var projectjson={
                            "members":array
                        }
                        await project.update(projectjson);
                        res.status(200).send("Member added ! ");
                    }
                    else{
                        res.status(403).send("Member Already Exist! ");

                    }

            } catch (error) {
                res.status(400).send(error.message);
            }
}

const DeleteMemberFromProject = async (req, res, next) => {
    var array=[];
            try {
                    var project = await firestore.collection('projects').doc(req.params.id);
                    const data = await project.get();
                    array=data.data().members
                    const x =array.indexOf(req.body.member,0)
                    console.log(x);
                    if (x>0){
                        array.pop(x);
                        var projectjson={
                            "members":array
                        }
                        await project.update(projectjson);
                        res.status(200).send("member deleted ! ");
                    }
                    else{
                        res.status(403).send("Member not found !")
                    }
            } catch (error) {
                res.status(400).send(error.message);
            }
}


//Get Members !!!!
const GetMembers = async(req,res,next) => {
    var array=[];
            try {
                var project= await firestore.collection('projects').doc(req.params.id);
                const data= await project.get();
                array=data.data().members
                res.send(array);

            }catch(error){
                res.status(400).send(error.message);
            }
}
 const GetProjects = async (req, res, next) => {
            try {
                const projects = await firestore.collection('projects');
                const data = await projects.where("members", "array-contains", req.params.id ).get();
                const projectsArray = [];
                if (data.empty) {
                    res.status(404).send('No Project record found');
                } else {
                    data.forEach(doc => {
                        var project=new Object();
                        project["id"]=doc.id;
                        project["title"]=doc.data().title;
                        project["start_date"]=doc.data().start_date || "11/1/2023";
                        project["end_date"]=doc.data().end_date || "11/1/2023";
                        project["members"]=doc.data().members || "no member";
                        /// Add the rest of the attributes
                        projectsArray.push(project);
                    });
                    res.send(projectsArray);
                }
            } catch (error) {
                res.status(400).send(error.message);
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////

        const GetProject = async (req, res) => {
            const project_id=req.params.id;
            try {
                var project = await firestore.collection('projects').doc(project_id);
                project= await project.get()
                if (project) {
                    var project1=new Object();
                    project1["id"]=project.id;
                    project1["title"]=project.data().title;
                    project1["start_date"]=project.data().start_date || "11/1/2023";
                    project1["end_date"]=project.data().end_date || "11/1/2023";
                    project1["members"]=project.data().members || "no member";
                    res.send(project1);

                } 
                else {res.status(403).json("Project not found !")
                        }
            } catch (error) {
                res.status(400).send(error.message);
            }
        }
    
const deleteProject=async (req,res)=> {
        const project_id=req.params.id;
        try{
            const project = await firestore.collection('projects').doc(project_id);
            if(project){
                await project.delete();
                res.status(200).json("Project deleted !")
            }
            else{
                res.status(403).json("Project not found !")
            }
        }
        catch(e){
            res.status(403).json("Error!")
        }
    }
module.exports = {
    CreateProject,GetProjects,deleteProject,AddMemberToProject,DeleteMemberFromProject,GetProject
}