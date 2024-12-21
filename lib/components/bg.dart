import 'package:flutter/material.dart';
import 'package:run_dash/providers/screen_controller.dart';

class Bg extends StatelessWidget {
  final ScreenController screen;
  const Bg({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: List.generate(10, (index) {
            return Positioned(
              top: (screen.height / 2),
              left: (index * 200),
              child: Image.asset(
                "assets/images/road.png",
                width: 200,
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            );
          }),
        ),
        Positioned(
          // bg
          bottom: 0,
          left: 0,
          child: Image.asset(
            "assets/images/bg.gif",
            width: screen.width,
            height: (screen.height / 2) - 100,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
