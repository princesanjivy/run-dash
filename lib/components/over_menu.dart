import 'package:flutter/material.dart';
import 'package:run_dash/components/my_button.dart';
import 'package:run_dash/screens/game.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class OverMenu extends StatelessWidget {
  const OverMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Game Over!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 56,
                fontFamily: "PixelFont",
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            GameButton(
              text: "Menu",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
