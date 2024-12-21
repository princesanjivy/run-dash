import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:run_dash/components/bg.dart';
import 'package:run_dash/components/over_menu.dart';
import 'package:run_dash/enums/player.dart';
import 'package:run_dash/providers/game_controller.dart';
import 'package:run_dash/providers/player_controller.dart';
import 'package:run_dash/providers/screen_controller.dart';

import 'dart:math' as math;

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  late ScreenController screen;
  late PlayerController playerController;

  final FocusNode _focusNode = FocusNode(); // used by keyboard listener

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initProviders();

    update();
  }

  void initProviders() {
    screen = Provider.of<ScreenController>(
      context,
      listen: false,
    ); // if possible read from context instead
    playerController = Provider.of<PlayerController>(
      context,
      listen: false,
    );
    playerController.updateBoundaryRight = screen.width;

    // set initial height for the player
    playerController.pos.y = (screen.height / 2) - 20;
  }

  void update() {
    GameController controller = Provider.of<GameController>(
      context,
      listen: false,
    );

    const double speed = 100;

    controller.t = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (controller.trainPos.x > screen.width) {
        controller.reset();
      }
      controller.updateXPos = speed;

      // coin
      controller.onUpdate(20, playerController);

      if (controller.coinPos.y > (screen.height / 2) + 20) {
        controller.gameOver();
        controller.resetCoin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<GameController, ScreenController, PlayerController>(
        builder: (context, game, screen, playerController, _) {
      return KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowRight) {
            playerController.updateXPos(PlayerAction.right);
          } else if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            playerController.updateXPos(PlayerAction.left);
          }
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              
              Opacity(
                // Game
                opacity: game.canShowOverMenu ? 0.5 : 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      //bg
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/sky.jpg",
                        width: screen.width,
                        height: screen.height - 400,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      // train
                      top: 100,
                      right: game.trainPos.x,
                      child: Image.asset(
                        "assets/images/metro.png",
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      // score
                      top: 0,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   "Score: ${game.score}",
                          //   style: const TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 48,
                          //     fontFamily: "PixelFont",
                          //   ),
                          // ),
                          Text(
                            "Coins: ${game.coinsCollected}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 48,
                              fontFamily: "PixelFont",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: List.generate(10, (index) {
                        return Positioned(
                          top: ((screen.height) / 2) - 500,
                          left: (index * 600),
                          child: Image.asset(
                            "assets/images/track.png",
                            // width: 800,
                            height: 600,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      }),
                    ),
                    Positioned(
                      // coin
                      top: game.coinPos.y,
                      left: game.coinPos.x,
                      child: Image.asset(
                        "assets/images/animatedCoin.gif",
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      // temple
                      top: (screen.height / 2) - 25,
                      left: 500,
                      child: Image.asset(
                        "assets/images/temple.png",
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      // player
                      top: playerController.pos.y,
                      left: playerController.pos.x,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                          playerController.flip ? 0 : math.pi,
                        ),
                        child: Image.asset(
                          "assets/images/dashInCar.png",
                          width: 150,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  Bg(screen: screen) 
                  ],
                ),
              ),

// Game Over Menu
              game.canShowOverMenu
                  ? const OverMenu()
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
