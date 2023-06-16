// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lamascotte/event/timer.dart';
import 'package:lamascotte/scanner/scan_page.dart';
import 'package:lamascotte/widget/utils.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../../scenario/director_speaking.dart';
import '../../scenario/scenario.dart';
import '../../widget/button.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerAgence = TextEditingController();
  final controllerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String message = "50°13'41.9\"N 5°20'09.2\"E";

    return Material(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Stack(children: [
          imageHomePage(size, "assets/images/museum.png"),
          SafeArea(
              child: CountdownTimerDemo(
                  minutes: 5,
                  plan: "assets/images/event2.png",
                  unblockEvent2: true,
                  unblockEvent3: false)),
          Center(
            child: Form(
              key: _formKey,
              child: Container(
                height: size.height * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 248, 235, 204),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controllerAgence,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "Entrer le nom étrange"),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 120, 89, 71)),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              if (controllerAgence.text.toUpperCase() ==
                                  "DAILAMA") {
                                FlutterPhoneDirectCaller.callNumber(
                                    "0494361917");

                                List<String> recipents = [
                                  controllerPhoneNumber.text.toString()
                                ];
                                var duration = const Duration(seconds: 3);
                                sleep(duration);

                                AwesomeNotifications().createNotification(
                                    content: NotificationContent(
                                        id: 10,
                                        channelKey: 'basic_channel',
                                        title: 'Dailama Information',
                                        body:
                                            'Rendez-vous dans la partie Nourrisage',
                                        actionType: ActionType.Default));

                                sleep(duration);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScenarioPage(dialog: [
                                              SizedBox(height: 150),
                                              Director(
                                                  text:
                                                      "Bien joué ! \n Vous avez réussi à récupérer \n la géolocalisation du lama"),
                                              Director(
                                                  text:
                                                      "Rendez-vous dans dans la zone indiqué !"),
                                              NavigateButton(
                                                  buttonName: "Suivant",
                                                  nextPage: ScanPage(
                                                      plan:
                                                          "assets/images/event3.png",
                                                      unblockEvent2: true,
                                                      unblockEvent3: true)),
                                            ])));
                              } else {
                                null; // Faire la page de défaite
                              }
                            }
                          },
                          child: const Text('Submit'),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

test(message, recipents) async {
  String _result =
      await sendSMS(message: message, recipients: recipents, sendDirect: true)
          .catchError((onError) {
    print(onError);
  });
  print(_result);
}
