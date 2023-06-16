// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lamascotte/event/event_2/call.dart';
import 'package:lamascotte/event/event_2/llama_speaking.dart';
import 'package:lamascotte/widget/utils.dart';
import '../../widget/button.dart';
import '../timer.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Material(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: [
              imageHomePage(size, "assets/images/museum.png"),
              SafeArea(
                  child: Wrap(
                runSpacing: size.height / 7,
                children: [
                  Container(
                      height: 50,
                      width: size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 248, 235, 204),
                      ),
                      child: CountdownTimerDemo(
                          minutes: 5,
                          plan: "assets/images/event2.png",
                          unblockEvent2: true,
                          unblockEvent3: false)),
                  LLama(
                      text:
                          "Waw vous êtes aussi intelligent qu’un lama *CRACHE*"),
                  LLama(
                      text:
                          "Quelque chose s’est passé dans votre téléphone ..."),
                  NavigateButton(buttonName: "Suivant", nextPage: CallPage())
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
