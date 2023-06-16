// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lamascotte/event/event_2/contact.dart';

import 'package:lamascotte/event/event_2/llama_speaking.dart';
import 'package:lamascotte/scenario/scenario.dart';
import 'package:lamascotte/widget/utils.dart';

import '../../widget/button.dart';
import '../timer.dart';

class EnigmaPage extends StatefulWidget {
  const EnigmaPage({Key? key}) : super(key: key);

  @override
  State<EnigmaPage> createState() => _EnigmaPageState();
}

class _EnigmaPageState extends State<EnigmaPage> {
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
                runSpacing: size.height / 25,
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
                          minutes: 10,
                          plan: "assets/images/event2.png",
                          unblockEvent2: true,
                          unblockEvent3: false)),
                  LLama(text: "Laquelle de ces races de lama est l'intruse ?"),
                  NavigateButton(
                      buttonName: "Chaku",
                      nextPage: ScenarioPage(dialog: [
                        SizedBox(height: 100),
                        LLama(text: "Eh non, un petit effort ! "),
                        LLama(
                            text:
                                "Le Chaku est une variété de lama constituée d’une fourrure a un seul manteau et un long pelage."),
                        Image.asset("assets/images/chacku.jpg"),
                        NavigateButton(
                            buttonName: "Réessayer", nextPage: EnigmaPage())
                      ])),
                  NavigateButton(
                      buttonName: "Llamingo",
                      nextPage: ScenarioPage(dialog: [
                        SizedBox(height: 100),
                        LLama(
                            text:
                                "Eh non, un petit effort ! \n Le Llamingo est proche du lama originaire de l’Équateur. "),
                        LLama(
                            text:
                                "Sa fourrure est composée de deux couches. Il possède un long cou puissant."),
                        Image.asset(
                          "assets/images/lama-llamingo_600x600.webp",
                          height: 200,
                        ),
                        NavigateButton(
                            buttonName: "Réessayer", nextPage: EnigmaPage())
                      ])),
                  AddContactPage(),
                  NavigateButton(
                      buttonName: "Silky",
                      nextPage: ScenarioPage(dialog: [
                        SizedBox(height: 100),
                        LLama(text: "Eh non, un petit effort "),
                        LLama(
                            text:
                                "Le Silky est presque identique au lama Wooly. Ils mesurent entre 1 et 1,2 m de hauteur."),
                        Image.asset(
                          "assets/images/lama-silky_600x600.webp",
                          height: 200,
                          width: 300,
                        ),
                        NavigateButton(
                            buttonName: "Réessayer", nextPage: EnigmaPage())
                      ])),
                  NavigateButton(
                      buttonName: "Ccara Sullo",
                      nextPage: ScenarioPage(dialog: [
                        SizedBox(height: 100),
                        LLama(text: "Eh non, un petit effort "),
                        LLama(
                            text:
                                "Le Ccara sullo a un corps plus \n grand et moins lainé que les autres \n types de lama."),
                        Image.asset(
                            "assets/images/lama-ccara-sullo_600x600.webp"),
                        NavigateButton(
                            buttonName: "Réessayer", nextPage: EnigmaPage())
                      ])),
                  NavigateButton(
                      buttonName: "Q'ara",
                      nextPage: ScenarioPage(dialog: [
                        SizedBox(height: 100),
                        LLama(text: "Eh non, un petit effort "),
                        LLama(
                            text:
                                "Le Q’ara se distingue par sa fourrure courte à double manteau. Sa tête ainsi que ses membres sont dépourvus de laine."),
                        Image.asset("assets/images/lama-qara_600x600.jpg"),
                        NavigateButton(
                            buttonName: "Réessayer", nextPage: EnigmaPage())
                      ])),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
