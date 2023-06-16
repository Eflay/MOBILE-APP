// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lamascotte/widget/head.dart';
import 'package:lamascotte/widget/utils.dart';

class ScenarioPage extends StatefulWidget {
  final List<Widget> dialog;
  const ScenarioPage({Key? key, required this.dialog}) : super(key: key);

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          imageHomePage(size, "assets/images/museum.png"),
          Head(plan: "assets/images/plan2.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.dialog,
          )
        ],
      ),
    );
  }
}
