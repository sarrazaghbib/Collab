import 'package:flutter/material.dart';
import 'dart:math';
import 'project.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../projectHome/projecthome.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import './projectBox.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

var project_title;
var project_description;
var project_members;

class ProjectFormScreen extends StatefulWidget {
  @override
  _ProjectFormScreenState createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  Future CreateProject(
      BuildContext context, title, description, members) async {
    var url = "http://localhost:5000/api/project";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, double>{
          'title': title,
          'description': description,
          'members': members
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception('${response.body}');
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ownerController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ownerController.dispose();
    super.dispose();
  }

  TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New project"),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    } else {
                      project_title = value;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _date,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Select Date"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickeddate != null) {
                      setState(() {
                        _date.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: ownerController,
                  decoration: InputDecoration(
                      labelText: 'members',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please the number of members';
                    } else {
                      project_members = value;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      project_description = value;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("hello?");

                    if (formKey.currentState!.validate()) {
                      project Project = project(
                          titleController.value.text,
                          ownerController.value.text,
                          descriptionController.value.text,
                          new Random().nextInt(100));

                      projectBox.box.put(Project.key(), project);
                    }
                    CreateProject(context, 'ss', 'ss', 'ss');
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              )
            ],
          )),
    );
  }
}
