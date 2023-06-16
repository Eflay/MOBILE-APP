import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String imageAvatar;

  const Avatar({Key? key, required this.imageAvatar}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/${widget.imageAvatar}'),
          fit: BoxFit.contain
        ),
      ),
    );
  }
}
