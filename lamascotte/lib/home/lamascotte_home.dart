// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lamascotte/scenario/director_speaking.dart';
import 'package:lamascotte/scanner/scan_page.dart';
import 'package:lamascotte/scenario/scenario.dart';
import 'package:lamascotte/widget/utils.dart';
import 'package:lamascotte/scenario/woman_speaking.dart';
import '../event/event_1/gyro_maze.dart';
import '../widget/button.dart';
import '../widget/text_area.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
        
      child: Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Stack(children: [
              imageHomePage(size, "assets/images/Lama.png"),
              SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextArea(text: 'Lamascotte'),
                  NavigateButton(
                      buttonName: 'Start',
                      nextPage: ScenarioPage(
                        dialog: [
                          SizedBox(height: 150),
                          Director(
                              text:
                                  "Bonjour à toi jeune détective !\nLe musée “Lamascotte” a besoin de ton aide !"),
                          Woman(text: "En quoi puis-je vous aider ?"),
                          Director(
                              text:
                                  "Je vous récapitule, \n un lama farceur sévit dans notre région, aider nous à le capturer !"),
                          NavigateButton(
                              buttonName: "Suivant",
                              nextPage: ScenarioPage(dialog: [
                                SizedBox(height: 150),
                                Director(
                                    text:
                                        "Si vous ne le retrouvez pas\n dans l’heure, les vrais lamas risquent d’être corrompu \npar lui !"),
                                Director(
                                    text:
                                        "J'aimerais que vous le retrouviez \npour la sûreté du musée, je compte sur vous."),
                                Woman(
                                    text:
                                        "Je ferai de mon mieux, je reviendrai avec ce lama ..."),
                                NavigateButton(
                                    buttonName: "Suivant",
                                    nextPage: ScanPage(
                                        plan: "assets/images/event1.png",
                                        unblockEvent2: false,
                                        unblockEvent3: false))
                              ]))
                        ],
                      ))
                ],
              )),
            ])),
      ),
    );
  }
}
