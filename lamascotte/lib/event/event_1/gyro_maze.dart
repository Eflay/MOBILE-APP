// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamascotte/event/event_1/game/gyro_maze_game.dart';
import 'package:lamascotte/event/event_1/utils/direction.dart';
import 'package:lamascotte/event/timer.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// main game for the application
class GyroMaze extends StatefulWidget {
  /// create the game
  const GyroMaze({super.key});

  @override
  State<GyroMaze> createState() => _GyroMazeState();
}

class _GyroMazeState extends State<GyroMaze> with WidgetsBindingObserver {
  late final GyroMazeGame _game;

  late bool showController;

  late StreamSubscription<AccelerometerEvent>? subscription;

  late double rotationX = 0;
  late double rotationY = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _game = GyroMazeGame(context: context);
    showController = false;

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      subscription = accelerometerEvents.listen(handleGyroAccel);
    }
    rotationX = 0;
    rotationY = 0;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // resume the engine when the app is back active
      _game.resumeEngine();
    } else {
      // pause the engine when the app is inactive
      _game.pauseEngine();
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void handleGyroAccel(AccelerometerEvent event) {
    if (!showController) {
      final dir = Vector2(-event.x, event.y);
      if (dir.length > 1) {
        dir.normalize();

        // the half coverage of the collision towards the side.
        // If collision falls under this, it is considered collided.
        // Else, it is considered not collided.
        DirectionHelper.directionCallbackFromNormal(
          normal: dir,
          downCallback: () => _game.ballDirection = Direction.down,
          upCallback: () => _game.ballDirection = Direction.up,
          leftCallback: () => _game.ballDirection = Direction.left,
          rightCallback: () => _game.ballDirection = Direction.right,
        );
      } else {
        _game.ballDirection = Direction.none;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controllerSize = min(
      MediaQuery.of(context).size.height * 0.3,
      MediaQuery.of(context).size.width * 0.5,
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: GameWidget(
                    game: _game,
                    backgroundBuilder: (context) => Stack(
                          children: [
                            Image(
                              image: AssetImage("assets/images/Canyon.webp"),
                              fit: BoxFit.cover,
                              height: size.height,
                            ),
                            Center(
                              child: Container(
                                color: Color.fromARGB(150, 250, 200, 200),
                                height: size.height * 0.38,
                                width: size.width * 0.8,
                              ),
                            )
                          ],
                        )),
              ),
              CountdownTimerDemo(
                  minutes: 3,
                  plan: "assets/images/event1.png",
                  unblockEvent2: false,
                  unblockEvent3: false),
              Align(),
            ],
          ),
        ),
      ),
    );
  }
}
