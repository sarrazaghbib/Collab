import 'package:collabapp/screens/members/membersView.dart';
import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../projectHome/projecthome.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../Global.dart' as global;

var data = [];
var id = global.project_id;
Future<List> getMember() async {
  data = global.members;
  return data;
}

Future DeleteMember(
  BuildContext context,
  String memberEmail,
) async {
  try {
    var url = 'https://backendmobile-tje6.onrender.com/api/deletemember/';
    url = url + id;
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'member': memberEmail,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => projectsView()));
      print("hello?");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.body);
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
  }
}

class members extends StatefulWidget {
  const members({super.key});

  @override
  State<members> createState() => _members();
}

//should be modified to get the members of that specific project

class _members extends State<members> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getMember(),
      builder: ((context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Center(child: Text("No Project Founds!")),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BuildCard(context, index),
              );
            },
          );
        }
      }),
    );
  }
}

Widget BuildCard(BuildContext context, int index) {
  return (Center(
      child: Padding(
    padding: EdgeInsets.only(
      left: 12.0,
      right: 12.0,
    ),
    child: Container(
      height: 80,
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 13, 71, 161),
          Color.fromARGB(255, 21, 101, 192),
          Color.fromARGB(255, 66, 165, 245)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                data[index],
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Avenir',
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 14.0,
            color: Colors.white,
            onPressed: () {
              DeleteMember(context, data[index]);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  )));
}
