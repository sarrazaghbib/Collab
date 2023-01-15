import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../projectHome/projecthome.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../Global.dart' as global;

var data = [];
Future DeleteProject(
  BuildContext context,
  String idd,
) async {
  try {
    var url = 'https://backendmobile-tje6.onrender.com/api/projects/';
    url = url + idd;
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => projectsView()));
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

class projects extends StatefulWidget {
  const projects({super.key});

  @override
  State<projects> createState() => _projects();
}

Future<List> getData() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var user = auth.currentUser;
  var url;
  url = "https://backendmobile-tje6.onrender.com/api/projects";
  if (user != null) {
    try {
      url = await url + "/" + user.email;

      print(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = await json.decode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
  return data;
}

class _projects extends State<projects> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getData(),
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
    child: GestureDetector(
      onTap: () {
        global.project_id = data[index]["id"];
        global.members = data[index]["members"];
        global.title = data[index]["title"];
        global.start_date = data[index]["start_date"];
        global.end_date = data[index]["end_date"];
        print(global.members);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => projectHome()));
      },
      child: Container(
        height: 150,
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
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 24.0,
                color: Colors.white,
                onPressed: () {
                  var taskId = (data[index]["id"]);
                  DeleteProject(context, taskId);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    data[index]["title"],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Center(
                child: Text(
                  data[index]["members"][0],
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir',
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '${data[index]["start_date"]}  -  ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Center(
                        child: Text(
                          data[index]["end_date"],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    ),
  )));
}
