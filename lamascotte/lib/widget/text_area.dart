// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  final String text;

  
  const TextArea({Key? key, required this.text}): super(key: key);

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        //margin: EdgeInsets.only(bottom: 700),
        width: size.width*0.75,
        //height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 235, 204),
          borderRadius: BorderRadius.circular(10)),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
      )
    );
  }
}
