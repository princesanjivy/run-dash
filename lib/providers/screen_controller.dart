import 'package:flutter/material.dart';

class ScreenController with ChangeNotifier {
  double _screenWidth = 0;
  double _screenHeight = 0;
  late Size _screenSize;

  //   Calculate screen sizes
  void calcSize(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenSize = Size(_screenWidth, _screenHeight);
    // notifyListeners();
  }

  double get width => _screenWidth;
  double get height => _screenHeight;

  Size get size => _screenSize;
}
