import 'package:flutter/material.dart';

class GameController with ChangeNotifier {
  bool isPaused = false;

  set togglePause(bool b) {
    isPaused = b;
    notifyListeners();
  }
}
