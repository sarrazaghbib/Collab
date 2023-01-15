import 'dart:js';
import 'package:collabapp/screens/members/members.dart';
import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import '../Global.dart' as global;

var id = global.project_id;

Future<Member> addMember(
  BuildContext context,
  String email,
) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var url;
    url = 'https://backendmobile-tje6.onrender.com/api/projects';
    if (user != null) {
      url = url + "/" + id;
    }
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'member': email,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      return Member(
        email: "",
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      return Member(
        email: "",
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return Member(
      email: "",
    );
  }
}

class Member {
  final String email;
  const Member({
    required this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      email: json['email'],
    );
  }
}

final TextEditingController _emailcontroller = TextEditingController();

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 13, 71, 161),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 13, 71, 161),
            Color.fromARGB(255, 21, 101, 192),
            Color.fromARGB(255, 66, 165, 245)
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Members",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: members(), // projects contains the card widgets
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // a popup of add a member through entering his e-mail @
            //Add here the function that will add the member to the list
            // Add here the function that will look for the member in the dataBase and add his Id to the list of members of the current project
            showDialog(
              context: context,
              //Create (Alert==POPUP)
              builder: (context) => AlertDialog(
                title: Text("Enter the member's e-mail"),
                content: TextField(
                  controller: _emailcontroller,
                  decoration:
                      const InputDecoration(hintText: 'Enter Description'),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        //the function that remove the pop up !
                        Navigator.of(context).pop();
                        addMember(context, _emailcontroller.text);
                      },
                      child: Text("Add"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({
  label,
  obscureText = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            )),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
