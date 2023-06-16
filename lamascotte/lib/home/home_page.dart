// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lamascotte/home/lamascotte_home.dart';
import 'package:lamascotte/widget/utils.dart';
import 'package:lamascotte/widget/button.dart';
import 'package:lamascotte/widget/text_area.dart';
import 'package:request_permission/request_permission.dart';
import '../event/event_2/start_event_2.dart';

import '../event/event_2/start_event_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      List perms = [
        "android.permission.READ_PHONE_NUMBERS",
        "android.permission.CAMERA",
        "android.permission.WRITE_CONTACTS",
        "android.permission.ACTIVITY_RECOGNITION",
        "android.permission.SEND_SMS",
        "android.permission.POST_NOTIFICATIONS"
      ];

      String perm;
      int verifyPerm;
      int i = 0;
      verifyPerm = 0;
      RequestPermission requestPermission = RequestPermission.instace;

      for (perm in perms) {
        requestPermission.hasAndroidPermission(perm).then((test) => {
              if (test) {verifyPerm += 1},
              i += 1,
              if (verifyPerm != 6 && i == 6)
                {
                  showDialog(
                      context: context, builder: (context) => Permission())
                }
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      
        child: Scaffold(
          body: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: Stack(
                children: [
                  imageHomePage(size, "assets/images/museum.png"),
                  SafeArea(
                      child: Wrap(
                    runSpacing: size.height / 20,
                    children: [
                      TextArea(text: 'Escape Museum'),
                      NavigateButton(
                          buttonName: 'Lamascotte', nextPage: StartPage()),
                      NavigateButton(
                          buttonName: "L'égoutillé", nextPage: HomePage()),
                      NavigateButton(
                          buttonName: 'Prostitut', nextPage: HomePage()),
                      NavigateButton(
                          buttonName: 'Mortadelle', nextPage: HomePage()),
                      NavigateButton(
                          buttonName: 'Angele', nextPage: HomePage()),
                      NavigateButton(
                          buttonName: 'Sauciflar', nextPage: EnigmaPage()),
                    ],
                  ))
                ],
              )),
        ),
      );
  }
}
