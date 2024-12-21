import 'package:flutter/material.dart';
import 'package:run_dash/enums/player.dart';
import 'package:run_dash/helpers/position.dart';

class PlayerController with ChangeNotifier {
  bool flip = false;
  final double speed = 100;

  Position pos = Position(10, 0);

  double boundaryLeft = 0;
  double boundaryRight = 0; // make private if needed;

  set updateBoundaryRight(double w) {
    boundaryRight = w - 150;
  }

  void updateXPos(PlayerAction action) {
    double delta = action.value * speed;

    if (action == PlayerAction.left) {
      if (pos.x > boundaryLeft) {
        pos.x += delta;
        flip = true;
      }
    } else if (action == PlayerAction.right) {
      if (pos.x < (boundaryRight)) {
        pos.x += delta;
        flip = false;
      }
    }

    notifyListeners();
  }
}
