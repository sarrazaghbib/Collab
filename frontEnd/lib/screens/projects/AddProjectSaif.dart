import 'package:collabapp/screens/calendar/calender_view.dart';
import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

Future<Project> createProject(
  BuildContext context,
  String title,
  String description,
  String start_date,
  String end_date,
) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var url;
    url = 'https://backendmobile-tje6.onrender.com/api/projects';
    if (user != null) {
      url = url + "/" + user.uid + "/" + user.email;
    }

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'start_date': start_date,
        'end_date': end_date,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => projectsView()));
      return Project(
        title: "",
        description: "",
        members: "",
        start_date: "",
        end_date: "",
      );
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
    return Project(
        title: "", description: "", members: "", start_date: "", end_date: "");
  }
}

class Project {
  final String title;
  final String description;
  final String members;
  final String start_date;
  final String end_date;

  const Project({
    required this.title,
    required this.description,
    required this.members,
    required this.start_date,
    required this.end_date,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      members: json['members'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }
}

class AddProject extends StatefulWidget {
  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _startdate = TextEditingController();
  final TextEditingController _enddate = TextEditingController();

  Future<Project>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"))),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, bottom: 160),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _titlecontroller,
                        decoration:
                            const InputDecoration(hintText: 'Enter Title'),
                      ),

                      TextField(
                        controller: _startdate,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today_rounded),
                            labelText: "Select Start Date"),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickeddate != null) {
                            setState(() {
                              _startdate.text =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),

                      TextField(
                        controller: _enddate,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today_rounded),
                            labelText: "Select End Date"),
                        onTap: () async {
                          DateTime? pickeddate1 = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickeddate1 != null) {
                            setState(() {
                              _enddate.text =
                                  DateFormat('yyyy-MM-dd').format(pickeddate1);
                            });
                          }
                        },
                      ),

                      TextField(
                        controller: _descriptioncontroller,
                        decoration: const InputDecoration(
                            hintText: 'Enter Description'),
                      ),
                      // inputFile(label: "Full Name",),
                      // inputFile(label: "Email"),
                      // inputFile(label: "State"),
                      // inputFile(label: "Password", obscureText: true),
                      // inputFile(label: "Confirm Password", obscureText: true),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, bottom: 80),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: Color(0xff0054FF),
                      onPressed: () {
                        setState(() {
                          _futureUser = createProject(
                            context,
                            _titlecontroller.text,
                            _descriptioncontroller.text,
                            _startdate.text,
                            _enddate.text,
                          );
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));
                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xff0054FF),
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text("Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ))
          ],
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
