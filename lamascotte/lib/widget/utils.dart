// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:request_permission/request_permission.dart';

Image imageHomePage(Size size, String image) {
  return Image.asset(
    image,
    fit: BoxFit.cover,
    height: size.height,
  );
}

class Permission extends StatelessWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    RequestPermission requestPermission = RequestPermission.instace;
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 248, 235, 204)),
        label: const Text(
          "S'il vous plait, veuillez accepter les permissions suivantes : caméra et d'écriture de contact.",
          style: TextStyle(
            fontSize: 25, 
            color: Colors.black,
            
            )
        ,),
        onPressed: () {
          requestPermission.requestMultipleAndroidPermissions({
          "android.permission.READ_PHONE_NUMBERS",
          "android.permission.CAMERA",
          "android.permission.WRITE_CONTACTS",
          "android.permission.ACTIVITY_RECOGNITION",
          "android.permission.SEND_SMS",
          "android.permission.POST_NOTIFICATIONS",
          }, 101);
          Navigator.pop(context);
        },
      )
    );
  }
}
