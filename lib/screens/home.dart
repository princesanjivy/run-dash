import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_dash/providers/game_controller.dart';
import 'package:run_dash/screens/game.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../components/my_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(builder: (context, game, _) {
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              left: 20,
              child: Text(
                "Highscore: ${game.highScore}",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 56,
                  fontFamily: "PixelFont",
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  WidgetAnimator(
                    atRestEffect: WidgetRestingEffects.bounce(),
                    child: const Text(
                      "Dash Drive",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 56,
                        fontFamily: "PixelFont",
                      ),
                    ),
                  ),
                  WidgetAnimator(
                    incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                    atRestEffect: WidgetRestingEffects.swing(),
                    child: Image.asset(
                      "assets/images/dashInCar.png",
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  GameButton(
                    onTap: () {
                      game.updateMenu(false);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyGame(),
                        ),
                      );
                    },
                    text: "Play",
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
