// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScenarioBubble extends StatefulWidget {
  final String text;
  const ScenarioBubble({Key? key, required this.text}) : super(key: key);

  @override
  State<ScenarioBubble> createState() => _ScenarioBubbleState();
}

class _ScenarioBubbleState extends State<ScenarioBubble> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        alignment: Alignment.center,
        color: Color.fromARGB(255, 248, 235, 204),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Itim",
            color: Colors.black,
            fontSize: 16
          )
        ),
      )
    );
  }
}