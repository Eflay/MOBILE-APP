// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:lamascotte/widget/head.dart';
import 'package:lamascotte/scanner/qr_code.dart';
import 'package:lamascotte/widget/utils.dart';

class ScanPage extends StatefulWidget {
  final String plan;
  final bool unblockEvent2;
  final bool unblockEvent3;
  const ScanPage(
      {Key? key,
      required this.plan,
      required this.unblockEvent2,
      required this.unblockEvent3})
      : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Material(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Stack(children: [
          imageHomePage(size, "assets/images/museum.png"),
          Center(
            child: Container(
                width: size.width * 0.70,
                height: size.width * 0.70,
                child: Scanner(
                    unblockEvent2: widget.unblockEvent2,
                    unblockEvent3: widget.unblockEvent3)),
          ),
          Head(plan: widget.plan),
        ]),
      ),
    );
  }
}
