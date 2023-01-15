import 'package:collabapp/model/event.dart';
import 'package:collabapp/resources/color_manager.dart';
import 'package:collabapp/screens/Events/event_list.dart';
import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:flutter/material.dart';
import 'package:collabapp/screens/ChangePass/ChangePass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collabapp/screens/calendar/calender_view.dart';
import 'package:collabapp/screens/Logout/Logout.dart';
import 'package:collabapp/screens/Chat/Screens/home_screen.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Projects",
    img: "assets/images/projects.png",
    screen: projectsView(),
  );
  Items item2 = Items(
    title: "Chat",
    img: "assets/images/teams.png",
    screen: HomeScreen(),
  );
  Items item3 = Items(
    title: "Events",
    img: "assets/images/events.png",
    screen: EventListScreen(),
  );
  Items item4 = Items(
    title: "Calender",
    img: "assets/images/calender.png",
    screen: Calendar(),
  );
  Items item5 = Items(
    title: "Change Password",
    img: "assets/images/pwd.png",
    screen: ChangePass(),
  );
  Items item6 = Items(
    title: "Logout",
    img: "assets/images/logout.png",
    screen: Logout(),
  );

  GridDashboard({super.key});

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
              onTap: () {
                Navigator.push(context, new MaterialPageRoute<Widget>(
                    builder: (BuildContext context) {
                  return data.screen;
                }));
              },
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
