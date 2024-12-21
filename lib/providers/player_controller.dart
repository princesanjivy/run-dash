import 'package:flutter/material.dart';
import 'package:run_dash/enums/player.dart';

class PlayerController with ChangeNotifier {
  final double speed = 100;

  double playerXPos = 10; // default 300 as roughly center

  double boundaryLeft = 0;
  double boundaryRight = 0; // make private

  set updateBoundaryRight(double w) {
    boundaryRight = w - 150;
    // notifyListeners();
  }

  void updateXPos(PlayerAction action) {
    double delta = action.value * speed;

    if (action == PlayerAction.left) {
      if (playerXPos > boundaryLeft) {
        playerXPos += delta;
      }
    } else if (action == PlayerAction.right) {
      if (playerXPos < (boundaryRight)) {
        playerXPos += delta;
      }
    }

    notifyListeners();
  }
}
