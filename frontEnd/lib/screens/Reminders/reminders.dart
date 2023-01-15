import 'dart:convert';
import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabapp/resources/color_manager.dart';
import "../Global.dart" as global;

var data = [];
var id = global.project_id;
var nothing;

Future<Reminder>? _futureUser;

Future<List> getData() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var user = auth.currentUser;
  var url;
  url = "https://backendmobile-tje6.onrender.com/api/reminders";
  if (user != null) {
    try {
      url = await url + "/" + id;
      print(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = await json.decode(response.body);
        print(data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
  return data;
}

final TextEditingController _textcontroller = TextEditingController();

Future<Reminder> createReminder(
  BuildContext context,
  String text,
) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var url;
    url = 'https://backendmobile-tje6.onrender.com/api/reminders';
    if (user != null) {
      url = url + "/" + id;
      print(url);
    }
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      nothing = response.body;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => projectsView()));

      return Reminder(
        text: "",
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      return Reminder(text: "");
    }
  } catch (e) {
    print("eee");
    return Reminder(text: "");
  }
}

Future DeleteReminder(
  BuildContext context,
  String id,
) async {
  try {
    var url = 'https://backendmobile-tje6.onrender.com/api/reminders/';
    url = url + id;
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
          context, MaterialPageRoute(builder: (context) => reminders()));
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

class Reminder {
  final String text;

  const Reminder({
    required this.text,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      text: json['text'],
    );
  }
}

class reminders extends StatefulWidget {
  const reminders({super.key});
  @override
  State<reminders> createState() => _reminders();
}

class _reminders extends State<reminders> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 71, 161),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 13, 71, 161),
          elevation: 0,
          centerTitle: true,
          title: const Text('Reminders'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: ((context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Center(child: Text("No Reminders Found!")),
              );
            } else {
              return ListWheelScrollView.useDelegate(
                itemExtent: 250,
                physics: FixedExtentScrollPhysics(),
                perspective: 0.004,
                controller: FixedExtentScrollController(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) {
                    return BuildCard(context, index);
                  },
                  childCount: data.length,
                ),
              );
            }
            ;
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //the function that show the pop up !
            showDialog(
              context: context,
              //Create (Alert==POPUP)
              builder: (context) => AlertDialog(
                title: Text("Add a reminder !"),
                content: TextField(
                  controller: _textcontroller,
                  decoration: const InputDecoration(hintText: 'Enter Text'),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        //the function that remove the pop up !
                        setState(() {
                          _futureUser = createReminder(
                            context,
                            _textcontroller.text,
                          );
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("ok"))
                ],
              ),
            );
            ;
          },
        ),
      ),
    );
  }
}

BuildCard(context, index) {
  return (Center(
    child: Container(
      height: 500,
      width: 400,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 112, 166, 242),
          Color.fromARGB(255, 196, 211, 245)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 238, 241, 245),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 12.0, right: 12.0, bottom: 9.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data[index]["text"],
                        style: TextStyle(
                            color: Color.fromARGB(255, 24, 21, 21),
                            fontFamily: 'Avenir',
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 25.0,
                  color: Color.fromARGB(255, 45, 62, 158),
                  onPressed: () {
                    setState() {
                      var remId = (data[index]["id"]);
                      DeleteReminder(context, remId);
                    }

                    ;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ));
}

void temp() {
  print('Floating Action Button Clicked');
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
