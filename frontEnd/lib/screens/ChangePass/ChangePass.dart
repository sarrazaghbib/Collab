import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);
  @override
  State<ChangePass> createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  final _passcontroller = TextEditingController();
  final _newpasscontroller = TextEditingController();
  final _repeatpasscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Image(image: AssetImage('assets/images/logoapp.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  (Text(
                    "Change Password",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x4d1d2cfb),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                    controller: _passcontroller,
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    decoration: const InputDecoration(
                                      labelText: "Old Password",
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Valid Password";
                                      } else {
                                        return null;
                                      }
                                    }),
                                TextFormField(
                                    controller: _newpasscontroller,
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    decoration: const InputDecoration(
                                      labelText: "New Password",
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Valid Password";
                                      } else {
                                        return null;
                                      }
                                    }),
                                TextFormField(
                                  controller: _repeatpasscontroller,
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  decoration: const InputDecoration(
                                      labelText: "Retype New Password",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    return _newpasscontroller.text == value
                                        ? null
                                        : "Passwords don't match. Please re-enter your new password";
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 15.0,
                              textStyle:
                                  const TextStyle(color: Colors.blueAccent)),
                          child: const Text('Change Password'),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 15.0,
                              textStyle:
                                  const TextStyle(color: Colors.blueAccent)),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
