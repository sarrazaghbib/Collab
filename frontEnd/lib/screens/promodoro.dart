import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int workTime = 25;
  int breakTime = 5;
  Timer? timer;
  int counter = 25 * 60;

  //start function
  void _startTimer(int timeInMinutes) {
    counter = timeInMinutes * 60;
    timer = Timer.periodic(const Duration(seconds: 1), ((timer) {
      if (counter == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          counter--;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text("Pomodoro Timer"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${counter ~/ 60 < 10 ? "0${counter ~/ 60}" : counter ~/ 60} : ${counter % 60 < 10 ? "0${counter % 60}" : counter % 60}",
            style: TextStyle(
              color: Colors.white,
              fontSize: max(120, MediaQuery.of(context).size.width / 8),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () {
                  _startTimer(25);
                },
                fillColor: Colors.lightBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                shape: const StadiumBorder(),
                child: const Text(
                  "Start Timer",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              RawMaterialButton(
                onPressed: () {
                  _startTimer(5);
                },
                fillColor: Colors.lightBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                shape: const StadiumBorder(),
                child: const Text(
                  "Start Break",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
