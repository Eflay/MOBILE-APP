import 'package:flutter/material.dart';
import 'scenario_bubble.dart';
import 'circle_avatar.dart';

class Director extends StatefulWidget {
  final String text;

  const Director({Key? key, required this.text}) : super(key: key);

  @override
  State<Director> createState() => _DirectorState();
}

class _DirectorState extends State<Director> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(
        flex: 1,
        child: SizedBox(
          height: 110,
          child: Avatar(imageAvatar: "director.png"),
        ),
      ),
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 130,
          child: ScenarioBubble(
            text: widget.text,
          ),
        ),
      )
    ]);
  }
}
