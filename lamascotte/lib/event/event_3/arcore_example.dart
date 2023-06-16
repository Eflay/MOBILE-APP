// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:lamascotte/event/timer.dart';
import 'package:lamascotte/widget/button.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../home/home_page.dart';
import '../../scenario/director_speaking.dart';
import '../../scenario/scenario.dart';
import '../../widget/utils.dart';

class ARPage extends StatefulWidget {
  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(children: [
          imageHomePage(size, "assets/images/museum.png"),
          SafeArea(
            child: CountdownTimerDemo(
                minutes: 1,
                plan: "assets/images/event3.png",
                unblockEvent2: true,
                unblockEvent3: true),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: ArCoreView(
                        onArCoreViewCreated: _onArCoreViewCreated,
                        enableTapRecognizer: true,
                      ),
                    )
                  ]))
        ]),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);

    _addSphere(arCoreController);
  }

  void onTapHandler(String name) {
    Navigator.pop(context);
    // Future.delayed(Duration.zero, () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ScenarioPage(dialog: [
                  SizedBox(height: 150),
                  Director(
                      text:
                          "Bien joué ! Vous avez réussi à retrouver le lama farceur"),
                  Director(text: "Je vous dois une fière chandelle !"),
                  NavigateButton(buttonName: "Terminer", nextPage: HomePage())
                ]))));
  }
}

void _addSphere(ArCoreController controller) {
  final material = ArCoreMaterial(color: Color.fromARGB(150, 238, 73, 197));
  final sphere = ArCoreSphere(
    materials: [material],
    radius: 0.2,
  );
  final node = ArCoreNode(
    shape: sphere,
    position: vector.Vector3(3, 5, 8),
  );
  controller.addArCoreNode(node);
}
