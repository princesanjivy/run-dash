import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:run_dash/enums/player.dart';
import 'package:run_dash/providers/player_controller.dart';
import 'package:run_dash/providers/screen_controller.dart';
import 'dart:math' as math;

import 'package:run_dash/providers/train_controller.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  late ScreenController screen;
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
    update();
  }

  void init() {
    screen = Provider.of<ScreenController>(context,
        listen: false); // read from context instead
    PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);
    playerController.updateBoundaryRight = screen.width;
  }

  void update() {
    TrainController trainController =
        Provider.of<TrainController>(context, listen: false);

    const double speed = 100;
    Timer t = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (trainController.trainXPos > screen.width) {
        trainController.reset();
      }
      trainController.updateXPos = speed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ScreenController, PlayerController, TrainController>(
        builder: (
      context,
      screen,
      playerController,
      trainController,
      _,
    ) {
      return KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowRight) {
            // do right
            print("right");
            playerController.updateXPos(PlayerAction.right);
          } else if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            // do left
            print("left");
            playerController.updateXPos(PlayerAction.left);
          }
        },
        child: Scaffold(
          // backgroundColor: Colors.bl,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                //bg
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/sky.png",
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                // train
                top: 100,
                right: trainController.trainXPos,
                child: Image.asset(
                  "assets/images/metro.png",
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                // player
                top: (screen.height / 2) - 50,
                left: playerController.playerXPos,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image.asset(
                    "assets/images/dashInCar.png",
                    width: 150,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Stack(
                children: List.generate(10, (index) {
                  return Positioned(
                    top: (screen.height / 2),
                    left: (index * 200),
                    child: Image.asset(
                      "assets/images/road.png",
                      width: 200,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
