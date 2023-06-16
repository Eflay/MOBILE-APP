import 'package:flutter/material.dart';
import '../../scenario/circle_avatar.dart';
import '../../scenario/scenario_bubble.dart';


class LLama extends StatefulWidget {
  final String text;
  const LLama({Key? key, required this.text}) : super(key: key);

  @override
  State<LLama> createState() => _LLamaState();
}

class _LLamaState extends State<LLama> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(
        flex: 1,
        child: SizedBox(
          height: 110,
          child: Avatar(imageAvatar: "lama-farceur.png"),
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
