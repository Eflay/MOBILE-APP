import 'package:flutter/material.dart';

class Head extends StatefulWidget {
  final String plan;
  const Head({Key? key, required this.plan}): super(key: key);

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: size.width*0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Image.asset("assets/images/map.png"),
                iconSize: 100,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Image(
                    image: AssetImage(widget.plan),
                    fit: BoxFit.cover,
                    )
                  ),
                )
              ),
            ),
            Container(
              height: 50,
              width: size.width*0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
            ),
          ],
        )
      
    );
  }
}