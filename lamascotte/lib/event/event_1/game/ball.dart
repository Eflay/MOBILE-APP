// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, recursive_getters

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamascotte/event/event_1/game/wall.dart';
import 'package:lamascotte/event/event_1/utils/direction.dart';
import 'package:lamascotte/event/event_2/start_event_2.dart';

import '../../../scanner/scan_page.dart';
import '../../../scenario/director_speaking.dart';
import '../../../scenario/scenario.dart';
import '../../../widget/button.dart';
import '../gyro_maze.dart';

/// ball component for the game
class Ball extends SpriteComponent with CollisionCallbacks, KeyboardHandler {
  /// create a single ball component
  ///
  /// - [size] is a required parameter
  /// - [position] is default to (0, 0)
  /// - [speed] is default to 30
  /// - [direction] is default to [Direction.none]
  final BuildContext pageContext;
  Ball({
    required double size,
    Vector2? position,
    this.speed = 30,
    this.direction = Direction.none,
    required this.pageContext,
  }) : super(size: Vector2.all(size), position: position ?? Vector2.zero());

  /// set / get the speed of the ball movement
  double speed;

  /// set / get the direction of the ball
  ///
  /// Deafults to [Direction.none]
  Direction direction;

  bool _hasCollidedUp = false;
  bool _hasCollidedDown = false;
  bool _hasCollidedLeft = false;
  bool _hasCollidedRight = false;
  
  BuildContext get context => context;

  @override
  Future<void>? onLoad() async {
    // debugMode = true;
    sprite = await Sprite.load('llama.png');
    await add(
      CircleHitbox(),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _moveBall(dt);
  }

  /// move the ball with delta passed
  void _moveBall(double dt) {
    switch (direction) {
      case Direction.up:
        if (!_hasCollidedUp) {
          position += Vector2(0, -speed * dt);
          
        }
        break;
      case Direction.down:
        if (!_hasCollidedDown) {
          position += Vector2(0, speed * dt);
        }
        break;
      case Direction.left:
        if (!_hasCollidedLeft) {
          position += Vector2(-speed * dt, 0);
          
        }
        break;
      case Direction.right:
        if (!_hasCollidedRight) {
          position += Vector2(speed * dt, 0);
          
        }
        break;
      case Direction.none:
        break;
    }
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    Direction? keyDirection;
    if (isKeyDown) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
          event.logicalKey == LogicalKeyboardKey.keyW) {
        keyDirection = Direction.up;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
          event.logicalKey == LogicalKeyboardKey.keyS) {
        keyDirection = Direction.down;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.keyA) {
        keyDirection = Direction.left;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        keyDirection = Direction.right;
      }
    }

    if (isKeyDown && keyDirection != null) {
      direction = keyDirection;
      // returns false as the key handler is being handled
      return false;
    }

    // returns true as the key handler is not being handled
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Wall) {
      if(other.type == EntryExit.exit){
        Navigator.pop(pageContext, GyroMaze());
        // Future.delayed(Duration.zero, () {
        Navigator.push(
          pageContext,
          MaterialPageRoute(builder: ((pageContext) => ScenarioPage(
            dialog: [
              SizedBox(height: 150),
              Director(text: "Votre lama a prit peur à la sortie du canyon."),
              Director(text: "Faite appel a notre agence DaiLama pour vous aider à le géolocaliser !"),
              NavigateButton(buttonName: "Suivant", nextPage: ScanPage(plan: "assets/images/event2.png",unblockEvent2: true, unblockEvent3: false))
            ]
          ))));
        
      }
      if (intersectionPoints.length == 2) {
        final ballCenter = position + Vector2(size.x / 2, size.y / 2);
        // generate a vector from the center of the ball to
        // the avg of the intersection points.
        final collisionNormal =
            ((intersectionPoints.first + intersectionPoints.last) / 2) -
                ballCenter;
        final distance = collisionNormal.length;
        // the half coverage of the collision towards the side.
        // If collision falls under this, it is considered collided.
        // Else, it is considered not collided.
        const angleThresholdInDegrees = 46.0;

        if (distance <= size.x / 2) {
          DirectionHelper.directionCallbackFromNormal(
            normal: collisionNormal,
            angleThreshold: angleThresholdInDegrees,
            rightCallback: () {
              _hasCollidedRight = true;
              _hasCollidedLeft = false;
            },
            leftCallback: () {
              _hasCollidedLeft = true;
              _hasCollidedRight = false;
            },
            upCallback: () {
              _hasCollidedUp = true;
              _hasCollidedDown = false;
            },
            downCallback: () {
              _hasCollidedDown = true;
              _hasCollidedUp = false;
            },
          );
        }
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _hasCollidedUp = false;
    _hasCollidedDown = false;
    _hasCollidedLeft = false;
    _hasCollidedRight = false;
  }
}


