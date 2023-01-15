
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collabapp/screens/Chat/models/contact_data.dart';
import 'package:collabapp/screens/Chat/theme.dart';
import 'package:collabapp/screens/Chat/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helpers.dart';


class ChatScreen extends StatefulWidget {
  String friendName; 
  String profilePicture; 
  String status;
  String uid;
  ChatScreen({Key?key, required this.friendName, required this.profilePicture,  required this.status,  required this.uid}):super(key:key);

  @override
  _ChatScreenState createState() => _ChatScreenState(friendName, profilePicture, status,uid);
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  String friendName; 
  String profilePicture; 
  String status;
  String uid;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();

  _ChatScreenState(this.friendName, this.profilePicture, this.status, this.uid);
  @override
  void initState(){
    checkUser();
    super.initState();
  }
  void checkUser() async {
    await chats
        .where('users', isEqualTo: {uid: null,currentUserId: null,})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) 
               async {
            if (querySnapshot.docs.isNotEmpty) {
            setState((){
                chatDocId = querySnapshot.docs.single.id;

                 });
            
            } else {
              await chats.add({
                'users': { uid: null,currentUserId: null},
                'fullNames':{currentUserId:FirebaseAuth.instance.currentUser?.displayName,uid:friendName },
              }).then((value) => {setState((){chatDocId = value.id;})});
            }
         
          },
        )
        .catchError((error) {});
  }
  bool isSender(String friend){
    return friend== currentUserId; 
  }
   void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName':friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: chats 
    .doc(chatDocId)
    .collection('messages')
    .orderBy('createdOn',descending: true)
    .snapshots(),
    builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if(snapshot.hasError){
        return const Center(child: Text("something went wrong"));
         }
      if(snapshot.connectionState == ConnectionState.waiting){
         return const Center(
           child : Text("Loading"),
         );
       }
     if(snapshot.hasData){
       var data ;
      var message;
      var date;
      return  Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: 
         _AppBarTitle(
          friendName: friendName,
          profilePicture : profilePicture,
          status: status,

        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon : CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ], toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: SafeArea(
        child: Column(
          children:  [
             Expanded(
              child: ListView(
                reverse:true ,
                children: snapshot.data!.docs.map((DocumentSnapshot document){
                  data = document.data()! ;
                  message = data['msg'].toString();
                  date = data['createdOn'] == null? DateTime.now().toString(): data['createdOn'].toDate().toString();
                  return isSender(data['uid'].toString())?
                    _MessageOwnTile(message:message ,messageDate: date,):
                    _MessageTile(message:message ,messageDate:date ,);
                }).toList(),  
              )
            ),
            const SizedBox(height: 10,),
             Padding(
              padding:const  EdgeInsets.only(bottom : 4.0),
              child: SafeArea(
        bottom: true,
        top: false,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: const  Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,),
                child: Icon(
                  CupertinoIcons.camera_fill,
                  
                ),
                
              ),
              
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(controller: _textController,
                  style: const TextStyle(fontSize: 14),
                  decoration: const  InputDecoration(
                    hintText: 'Type something...',
                    border :InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 24,
              ),
              child: GlowingActionButton(
                color: AppColors.accent,
                icon: Icons.send_rounded,
                onPressed: ()  => sendMessage(_textController.text) 
              ),
            ),
          ],
        ),
          )
            ),
          ],
        ),
      ),
    );}
     else{
      return const Center(
           child : Text("No Data"),
         );
     }

    });
      
      
      
      
      
     
  }
}


class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }):super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0 ,horizontal: 6.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius), 
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                )
              ),

            ),
          ],
        ),
      ),
    );
  }
}


class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }):super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 6.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius), 
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
                  message,
                  style: const TextStyle(color: AppColors.textLignt,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                )
              ),

            ),
          ],
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    Key? key,
    required this.label,
  }): super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ), 
      ),
    );
  }
}
 

class _AppBarTitle extends StatefulWidget {
   _AppBarTitle({
    Key? key, 
    required  this.friendName,
    required  this.profilePicture,
    required  this.status,

  }):super(key: key);

  String friendName;
  String profilePicture; 
  String status;

  @override
  State<_AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<_AppBarTitle> {
  String statusMessage = "";
  var statusColor; 
  void checkStatus(){
    if(widget.status == "Available"){
      statusMessage = "Online Now";
      statusColor = Colors.green;
    }else{
      statusMessage = "Disconnected";
      statusColor = Colors.red;
    }
  }
  @override
  Widget build(BuildContext context) {
    checkStatus();
    return Row(
      children: [
        Avatar.small(
          url: Helpers.randomPictureUrl(),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.friendName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14,),
              ),
              const SizedBox(height: 2,),
               Text( statusMessage,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

