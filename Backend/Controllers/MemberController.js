'use strict';
const firebase = require('../config');

const firestore = firebase.firestore();

const CreateMember = async (req, res, next) => {
            try {
                    var member={
                        "owner_id":req.params.owner_id,
                        "title":req.body.title,
                        "description":req.body.description
                    }
                    await firestore.collection('members').doc().set(member);
                    res.status(200).send("members added ! ");
            } catch (error) {
                res.status(400).send(error.message);
            }

}

 const GetMembers = async (req, res, next) => {
            try {
                const members = await firestore.collection('members');
                const data = await members.where("owner_id","==",req.params.id).get();
                const membersArray = [];
                if (data.empty) {
                    res.status(404).send('No Member record found');
                } else {
                    data.forEach(doc => {
                        var member=new Object();
                        member["id"]=doc.id;
                        member["title"]=doc.data().title;
                        member["start_date"]=doc.data().start_date || "11/1/2023";
                        member["end_date"]=doc.data().end_date || "11/1/2023";
                        /// Add the rest of the attributes
                        membersArray.push(member);
                    });
                    res.send(membersArray);
                }
            } catch (error) {
                res.status(400).send(error.message);
            }
        }
    
const deleteMember=async (req,res)=> {
        const member_id=req.params.id;
        try{
            const member = firestore.collection('members').doc(member_id);
            if(member){
                await member.delete();
                res.status(200).json("Member deleted !")
            }
            else{
                res.status(403).json("Member not found !")
            }
        }
        catch(e){
            res.status(403).json("Error!")
        }
    }
module.exports = {
    CreateMember,GetMembers,deleteMember
}