import 'package:flutter/material.dart';

import "dart:math";

class TrainController with ChangeNotifier {
  static final List<double> randomOff = [-2500, -3500, 6000, 8000];
  double trainXPos = -2500; // make private

  set updateXPos(double del) {
    trainXPos += del;
    notifyListeners();
  }

  void reset() {
    trainXPos = randomOff[Random().nextInt(4)];
    // print(delay);
    notifyListeners();
  }
}
