import 'package:collabapp/screens/QRCode/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../Global.dart' as global;
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyQR());
}

class MyQR extends StatelessWidget {
  const MyQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String data = global.project_id; // add the project id here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
