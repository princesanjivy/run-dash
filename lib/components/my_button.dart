import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GameButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      atRestEffect: WidgetRestingEffects.bounce(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: "PixelFont",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
