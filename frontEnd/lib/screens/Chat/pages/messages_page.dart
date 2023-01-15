import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:collabapp/screens/Chat/Screens/screens.dart';
import 'package:collabapp/screens/Chat/states/lib.dart';
import 'package:collabapp/screens/Chat/theme.dart';
import 'package:collabapp/screens/Chat/widgets/avatar.dart';
import 'package:collabapp/screens/Chat/models/models.dart';
import 'package:collabapp/screens/Chat/helpers.dart';
import 'package:flutter_mobx/flutter_mobx.dart';




class MessagesPage extends StatefulWidget {
   const MessagesPage({Key?key}):super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final Faker faker = Faker();
    @override
  void initState(){
    super.initState();
    chatState.refreshChatsForCurrentUser();
  }

  final date = Helpers.randomDate();
  @override
  Widget build(BuildContext context) {
      return 
      Observer(builder: (BuildContext context) =>
        CustomScrollView(
        slivers: [
           const SliverToBoxAdapter(
             child: _Stories(),
           ),
          SliverList(
          delegate: SliverChildListDelegate(
             chatState.messages.values.toList().map((data) {
              return
               _MessageTitle(
                 messageData: MessageData(
                uid:data['friendUid'],
                senderName: data['friendName'],
                message: data['msg'],
                messageDate: date,
                dateMessage: "_",
            ),
            );
            }).toList()))
        ],
      )
      );
    

    }
  }

class _MessageTitle extends StatefulWidget {
  const _MessageTitle({
    Key? key, 
    required this.messageData
  }) : super(key: key);
final MessageData messageData;

  @override
  State<_MessageTitle> createState() => _MessageTitleState();
}

class _MessageTitleState extends State<_MessageTitle> {
  void callChatScreen(
    BuildContext context, contactName, profilePicture, status,uid,) {
    Navigator.push(
        context,
       MaterialPageRoute(
            builder: (context) =>
                ChatScreen(friendName:contactName, profilePicture:contactName, status:contactName,uid:contactName,)
                ));
  }
  final profilePicture = Helpers.randomPictureUrl();
  String? status;
  @override
  Widget build(BuildContext context) {
   void getUserData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.messageData.uid).get();
      //profilePicture = userDoc.get('profilePic');
      status = userDoc.get('status');
  }
  getUserData();
    return InkWell(
       onTap: ()  {
       callChatScreen(
        context,
        widget.messageData.senderName,
        profilePicture,
        status,
        widget.messageData.uid
       );
       
       },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: profilePicture
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        widget.messageData.senderName
                      
                        ,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight : FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        widget.messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.messageData.dateMessage.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFaded,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('1',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textLignt,
    
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top:8, bottom: 16),
              child: Text(
                'Stories',
                style : TextStyle(
                  fontWeight : FontWeight.w900,
                  fontSize : 15,
                  color : AppColors.textFaded,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,int index) {
                  final faker = Faker();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 60,
                    child: _StoryCard(
                      storyData: StoryData(
                        name:faker.person.name(),
                        url : Helpers.randomPictureUrl(),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ], 
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key?key,
    required this.storyData,
    }) : super(key: key);

    final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
            )
          )
      ],
    );
  }
}