import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabapp/resources/color_manager.dart';
import 'projectdashboard.dart';
import './AddButtons.dart';

class AddHome extends StatelessWidget {
  const AddHome({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 13, 71, 161),
            Color.fromARGB(255, 21, 101, 192),
            Color.fromARGB(255, 66, 165, 245)
          ])),
          child: Column(children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 200,
                        child: AddButtons(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
