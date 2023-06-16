import 'package:flutter/material.dart';
import 'circle_avatar.dart';
import 'scenario_bubble.dart';

class Woman extends StatefulWidget {
  final String text;

  const Woman({Key? key, required this.text}) : super(key: key);

  @override
  State<Woman> createState() => _WomanState();
}

class _WomanState extends State<Woman> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 130,
          child: ScenarioBubble(text: widget.text),
        ),
      ),
      const Expanded(
        flex: 1,
        child: SizedBox(
          height: 110,
          child: Avatar(imageAvatar: "woman.png"),
        ),
      ),
    ]);
  }
}
