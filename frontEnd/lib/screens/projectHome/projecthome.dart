import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabapp/resources/color_manager.dart';
import 'projectdashboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Global.dart' as global;

var data = [];

var project_id = global.project_id;
var project_title = global.title;
var project_members = global.members;
var project_start_date = global.start_date;
var project_end_date = global.end_date;

class projectHome extends StatefulWidget {
  const projectHome({super.key});

  @override
  State<projectHome> createState() => _projectHomeState();
}

Future<List> getData() async {
  project_id = global.project_id;
  project_title = global.title;
  project_members = global.members;
  project_start_date = global.start_date;
  project_end_date = global.end_date;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var user = auth.currentUser;
  var url;
  url = "https://backendmobile-tje6.onrender.com/api/project";
  if (user != null) {
    try {
      url = await url + "/" + project_id;
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

class _projectHomeState extends State<projectHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color.fromARGB(255, 13, 71, 161),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 110,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      project_title,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      project_members[0],
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 226, 225, 228),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 2.0, top: 2.0),
                      height: 28.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${project_start_date} _ ",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 226, 225, 228),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            project_end_date,
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 226, 225, 228),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ProjectDashboard()
        ],
      ),
    );
  }
}
