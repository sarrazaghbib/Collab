import 'package:collabapp/main.dart';
import 'package:collabapp/screens/Home/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:collabapp/screens/utils/utils.dart';

class Register extends StatefulWidget {
  final Function() onClickedSignIn;
  const Register({Key? key, required this.onClickedSignIn}) : super(key: key);
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  var user = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var repass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                    "Let's Register",
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
                                  controller: user,
                                  decoration: const InputDecoration(
                                    labelText: "Username",
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                  validator: (value) =>
                                      value != null && value.length < 4
                                          ? 'Enter min. 4 characters'
                                          : null,
                                ),
                                TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                    labelText: "E-mail",
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'Enter a valid email'
                                      : null,
                                ),
                                TextFormField(
                                  controller: pass,
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value != null && value.length < 6
                                          ? 'Enter min. 6 characters'
                                          : null,
                                ),
                                TextFormField(
                                  controller: repass,
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  decoration: const InputDecoration(
                                      labelText: "Retype Password",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    return pass.text == value
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
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 15.0,
                              textStyle:
                                  const TextStyle(color: Colors.blueAccent)),
                          child: const Text('Register'),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.grey),
                              text: 'Already have an account? ',
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onClickedSignIn,
                                    text: 'Log In',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary))
                              ]),
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

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );
      final _auth = FirebaseAuth.instance;

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
