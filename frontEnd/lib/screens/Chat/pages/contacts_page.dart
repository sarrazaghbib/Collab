import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../Screens/chat_screen.dart';
import '../helpers.dart';
import '../models/models.dart';
import '../theme.dart';
import '../widgets/avatar.dart';

class ContactsPage extends StatelessWidget {
   ContactsPage({super.key});
  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  @override
 Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
    .collection("users")
    .where('uid',isNotEqualTo: currentUser)
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
      return CustomScrollView(
        slivers: [
          SliverList(
          delegate: SliverChildListDelegate(
            snapshot.data!.docs.map((DocumentSnapshot document) {
              final Faker faker = Faker();
               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
               return _ContactTile(
                contactData: ContactData(
                   contactName:data['fullName'] ?? "No Name" ,
                   status: data['status'] ?? "Unknown",
                  profilePicture: Helpers.randomPictureUrl(),
                  uid:data['uid']
      ),
    );
              
            }).toList()))
        ],
      );
     }else{
      return const Center(
           child : Text("No Data"),
         );
     }

    });
  }
}

class _ContactTile extends StatelessWidget {
   void callChatScreen(BuildContext context,ContactData contactData ) {
    Navigator.push(
        context,
       MaterialPageRoute(
            builder: (context) =>
                ChatScreen(
                  friendName: contactData.contactName,
                  profilePicture:contactData.profilePicture,
                  status:contactData.status,
                  uid: contactData.uid
                )));
  }
  const _ContactTile({
    Key? key, 
    required this.contactData
  }) : super(key: key);
final ContactData contactData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callChatScreen(context, contactData),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                child: Avatar.medium(url: contactData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        contactData.contactName,
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
                        contactData.status,
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
            ],
          ),
        ),
      ),
    );
  }
}

