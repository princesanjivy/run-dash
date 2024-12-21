import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:run_dash/enums/player.dart';
import 'package:run_dash/providers/player_controller.dart';
import 'package:run_dash/providers/screen_controller.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  // focus node to capture keyboard events
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  void init() {
    ScreenController screen = Provider.of<ScreenController>(context,
        listen: false); // read from context instead
    PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);
    playerController.updateBoundaryRight = screen.width;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScreenController, PlayerController>(
        builder: (context, screen, playerController, _) {
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
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                // player
                top: (screen.height / 2) - 100,
                left: playerController.playerXPos,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                // platform
                top: (screen.height / 2),
                child: Container(
                  width: screen.width,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
