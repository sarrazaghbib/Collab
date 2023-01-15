import 'dart:js';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../projects/projects.dart';
import '../projects/AddProject.dart';
import '../projectHome/add.dart';

class projectsView extends StatelessWidget {
  const projectsView({super.key});

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
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      "Projects",
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
                  child: projects(), // projects contains the card widgets
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // on pressed gets you to the add home where u choose either to create or join a project
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHome()),
          );
        },
      ),
    );
  }
}
