// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lamascotte/event/event_3/arcore_example.dart';
import 'package:lamascotte/scanner/scan_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:crypto/crypto.dart';

import '../event/event_1/gyro_maze.dart';
import '../event/event_2/start_event_2.dart';
import '../scenario/scenario.dart';
import '../scenario/woman_speaking.dart';
import '../widget/button.dart';

class Scanner extends StatefulWidget {
  final bool unblockEvent2;
  final bool unblockEvent3;
  const Scanner(
      {Key? key, required this.unblockEvent2, required this.unblockEvent3})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScan = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    int codeQr;
    var epreuve1 = utf8.encode("tillieux");
    var digestEpreuve1 = sha256.convert(epreuve1).toString();

    var epreuve2 = utf8.encode("lecointre");
    var digestEpreuve2 = sha256.convert(epreuve2).toString();

    var epreuve3 = utf8.encode("ramonfosse");
    var digestEpreuve3 = sha256.convert(epreuve3).toString();

    if (result?.code == digestEpreuve1) {
      codeQr = 1;
    } else if (result?.code == digestEpreuve2 && widget.unblockEvent2) {
      codeQr = 2;
    } else if (result?.code == digestEpreuve3 && widget.unblockEvent3) {
      codeQr = 3;
    } else {
      codeQr = 0;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Color.fromARGB(255, 248, 235, 204),
                    borderRadius: 10,
                    borderLength: 25,
                    borderWidth: 15,
                    cutOutSize: 250,
                  ),
                )),
            Expanded(
              flex: 4,
              child: Center(child: (codeQr == 0) ? null : redirect(codeQr)),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  redirect(int codeQr) {
    Navigator.pop(
        context,
        ScanPage(
            plan: "assets/images.plan2.png",
            unblockEvent2: false,
            unblockEvent3: false));

    switch (codeQr) {
      case 1:
        Future.delayed(Duration.zero, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ScenarioPage(
                        dialog: [
                          SizedBox(height: 150),
                          Woman(text: "*TOMBE*"),
                          Woman(
                              text:
                                  "Et là c'est le drame, nous sommes coincé dans le plus grand canyon de Lamascotte"),
                          NavigateButton(
                              buttonName: "Suivant", nextPage: GyroMaze())
                        ],
                      ))));
        });
        break;
      case 2:
        Future.delayed(Duration.zero, () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => EnigmaPage())));
        });
        break;
      case 3:
        Future.delayed(Duration.zero, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ScenarioPage(dialog: [
                        SizedBox(height: 150),
                        Woman(
                            text:
                                "*Qu'est ce que je pourrais trouver pour attirer mon lama*"),
                        Woman(text: "*Oh un bonbon*"),
                        NavigateButton(
                            buttonName: "Suivant", nextPage: ARPage())
                      ]))));
        });
        break;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
