// ignore_for_file: prefer_const_declarations, prefer_const_constructors, unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';

import '../scanner/scan_page.dart';
import '../scenario/director_speaking.dart';
import '../scenario/scenario.dart';
import '../widget/button.dart';

class CountdownTimerDemo extends StatefulWidget {
  final int minutes;
  final String plan;
  final bool unblockEvent2;
  final bool unblockEvent3;
  const CountdownTimerDemo({Key? key, required this.minutes,required this.plan,required this.unblockEvent2, required this.unblockEvent3}) : super(key: key);

  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  // Step 2
  Timer? countdownTimer;
  late Duration myDuration = Duration(minutes: widget.minutes);
  bool isFirstCall = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        defeat(context, widget.plan, widget.unblockEvent2, widget.unblockEvent3);
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 248, 235, 204),
      ),
      child: Center(
          child: Text(
        '$minutes:$seconds',
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 20,
          color: Colors.black,
          fontFamily: "Itim",
        ),
      )),
    );
  }
}

defeat(context,plan, unblockEvent2, unblockEvent3){
  Navigator.pop(context);
  return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            ScenarioPage(dialog: [
              SizedBox(height: 150),
              Director(
                  text:
                      "Oh non ... Vous n’avez pas réussi à retrouver le lama farceur"),
              NavigateButton(
                  buttonName: "Réessayer",
                  nextPage: ScanPage(plan: plan, unblockEvent2: unblockEvent2, unblockEvent3: unblockEvent3)),
            ])));
}