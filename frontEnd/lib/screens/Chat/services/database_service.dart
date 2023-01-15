import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  // saving the userdata
  Future saveUserData(String fullName, String email, String phone) async {
    return await users.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "profilePic": "",
      "uid": uid,
      "phone": phone,
    });
  }

  // getting user data
  Future getUserData(String uid) async {
    QuerySnapshot snapshot =
        await users.where("uid", isEqualTo: uid).get();
    return snapshot;
  }

}