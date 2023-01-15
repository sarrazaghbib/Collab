
import 'package:collabapp/screens/Home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {

  static Route route(email,userName) => MaterialPageRoute(
    builder: (context)=>ProfileScreen(
      userName: userName,
      email: email,
    ),
  );
  ProfileScreen({super.key, required this.email, required this.userName});

  String userName;
  String email;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body:Center(
        child: Column(
          children: [
            Hero(
              tag: 'hero-profile-pocture', 
              child: Avatar.large(url:Helpers.randomPictureUrl(), )
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.userName),
            ),
            const Divider(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), 
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Email : ", style: TextStyle(fontSize: 17)),
                  Text(widget.email, style: const TextStyle(fontSize: 17)),
                ],),
            ),

          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Get back"),
                      content: const Text("Are you sure you want to get back?"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: (() {
                            Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                           builder: (context) => Home()),
                                       (route) => false);
                          }),
                          // () async {
                          //   await authService.signOut();
                          //   Navigator.of(context).pushAndRemoveUntil(
                          //       MaterialPageRoute(
                          //           builder: (context) => Container()),  // bechir Logout
                          //       (route) => false);
                          // },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Get Back",
              style: TextStyle(color: Colors.black),
            ),
          )

          ],
        ),
      ),
      
    );
  }
}