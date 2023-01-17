import 'package:collabapp/screens/projects/projectsView.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import '../Global.dart' as global;

Future<Member> addMember(
  BuildContext context,
  String email,
  var id,
) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var url;
    url = 'https://backendmobile-tje6.onrender.com/api/projects';
    if (user != null) {
      url = url + "/" + id;
    }
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'member': email,
      }),
    );
    if (response.statusCode == 200) {
      return Member(
        email: "",
      );
    } else {
      return Member(
        email: "",
      );
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
    return Member(
      email: "",
    );
  }
}

class Member {
  final String email;
  const Member({
    required this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      email: json['email'],
    );
  }
}

class readQr extends StatelessWidget {
  const readQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRHome(title: 'QR Code Scanner'),
    );
  }
}

class QRHome extends StatefulWidget {
  const QRHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QRHome> createState() => _QRHomeState();
}

class _QRHomeState extends State<QRHome> {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) async {
      setState(() {
        result = event;
        // result contains the string scanned
      });

      if (result != null) {
        var k = 0;
        var id = result!.code;
        final FirebaseAuth auth = FirebaseAuth.instance;
        var user = auth.currentUser;
        var _member;
        if (user != null) {
          var User_email = user.email;
          if (User_email != null && k > 1) {
            _member = await addMember(context, User_email, id);
            k++;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => projectsView()),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 200,
                  width: 200,
                  child: QRView(key: _gLobalkey, onQRViewCreated: qr),
                ),
              ),
            ),
            Center(
              child: (result != null)
                  ? Text(
                      'code scanned') //Text('${result!.code}'): probably u should use this
                  : Text('Scan a code'),
            )
          ],
        ),
      ),
    );
  }
}
