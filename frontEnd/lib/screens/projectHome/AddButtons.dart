import 'package:collabapp/screens/projects/AddProjectSaif.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../QRCode/readqr.dart';
import '../projects/AddProject.dart';

class AddButtons extends StatelessWidget {
  const AddButtons({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "createproject_btn",
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 13, 71, 161),
                              Color.fromARGB(255, 21, 101, 192),
                              Color.fromARGB(255, 66, 165, 245)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddProject();
                                },
                              ),
                            );
                          },
                          child: Center(
                            child: Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Text(
                                    'Create Project',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
        const SizedBox(height: 90),
        Hero(
          tag: "createproject_btn",
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 13, 71, 161),
                              Color.fromARGB(255, 21, 101, 192),
                              Color.fromARGB(255, 66, 165, 245)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return readQr();
                                },
                              ),
                            );
                          },
                          child: Center(
                            child: Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Text(
                                    'Join Project',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
      ],
    );
  }
}
