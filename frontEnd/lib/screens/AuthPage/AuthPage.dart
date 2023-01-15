import 'package:flutter/material.dart';
import 'package:collabapp/screens/Login/login.dart';
import 'package:collabapp/screens/Register/register.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignUp: toggle)
      : Register(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
