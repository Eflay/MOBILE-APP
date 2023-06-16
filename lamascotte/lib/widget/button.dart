// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigateButton extends StatefulWidget {
  final String buttonName;
  final Widget nextPage;

  const NavigateButton(
      {Key? key,
      required this.buttonName,
      required this.nextPage})
      : super(key: key);
  @override
  State<NavigateButton> createState() => _NavigateButtonState();
}

class _NavigateButtonState extends State<NavigateButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(         
          width: size.width/2,
          height: size.height/18,
          margin: EdgeInsets.only(bottom: size.height/50), 
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Color.fromARGB(255, 248, 235, 204)),
            child: Text(
              widget.buttonName,
              style: TextStyle(fontSize: size.width/15, color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageTransition(child: widget.nextPage, type: PageTransitionType.fade),
              );
            },
          )),
    );
  }
}
