import 'dart:async';

import 'package:flutter/material.dart';
import 'package:run_dash/helpers/collide_check.dart';
import 'package:run_dash/helpers/random_pos.dart';
import 'package:run_dash/helpers/position.dart';
import 'package:run_dash/providers/player_controller.dart';

class GameController with ChangeNotifier {
  late Timer t;

  int highScore = 0;
  int coinsCollected = 0;

  void updateCoin(int i) {
    coinsCollected += i;
    notifyListeners();
  }

  bool isPaused = false;
  bool canShowOverMenu = false;

  void updateMenu(bool b) {
    canShowOverMenu = b;
    notifyListeners();
  }

  set togglePause(bool b) {
    isPaused = b;
    notifyListeners();
  }

  Position trainPos = Position(-1500, 0);

  Position coinPos = Position(300, 200);

  set updateXPos(double del) {
    trainPos.x += del;
    notifyListeners();
  }

  void onUpdate(double del, PlayerController player) {
    if (isColliding(
      coinPos.x,
      coinPos.y,
      player.pos.x,
      player.pos.y,
      92,
    )) {
      updateCoin(1);
      resetCoin();
    }
    coinPos.y += del;

    notifyListeners();
  }

  void reset() {
    trainPos.x = RandomOffset.coinOffset;

    notifyListeners();
  }

  void resetCoin() {
    coinPos = Position(RandomOffset.coinOffset, 10);

    notifyListeners();
  }

  void gameOver() {
    t.cancel();

    updateMenu(true);
    if (coinsCollected > highScore) {
      highScore = coinsCollected;
    }
    // canShowOverMenu = false;
    coinsCollected = 0;

    notifyListeners();
  }
}
