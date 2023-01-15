import 'package:collabapp/main.dart';
import 'package:collabapp/resources/color_manager.dart';
import 'package:collabapp/screens/Reminders/reminders.dart';
import 'package:collabapp/screens/Task_Test/views/home.dart';
import 'package:collabapp/screens/draw.dart';
import 'package:collabapp/screens/members/membersView.dart';
import 'package:collabapp/screens/members/membersView.dart';
import 'package:collabapp/screens/promodoro.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../QRCode/QRCodeGenerator.dart';

class ProjectDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Tasks",
    img: "assets/images/tasks.png",
    screen: HomeTask(),
  );

  Items item2 = Items(
    title: "White Board",
    img: "assets/images/board.png",
    screen: DrawingBoard(),
  );
  Items item3 = Items(
    title: "Reminders",
    img: "assets/images/Reminders.png",
    screen: reminders(),
  );
  Items item4 = Items(
    title: "QR Code",
    img: "assets/images/membres.png",
    screen: MyQR(),
  );
  Items item5 = Items(
    title: "Promodoro",
    img: "assets/images/timer.png",
    screen: HomeScreen(),
  );
  Items item6 = Items(
    title: "Members",
    img: "assets/images/team.png",
    screen: MembersView(),
  );

  ProjectDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = ColorManager.button;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: (() => Navigator.push(context,
                      new MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                    return data.screen;
                  }))),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorManager.lightblue,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 50,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 2, 2, 2),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  Widget screen;

  Items({required this.title, required this.img, required this.screen});
}
