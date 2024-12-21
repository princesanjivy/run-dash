import 'dart:math' as math;

class RandomOffset {
  static final List<double> randomOff = [
    -2500,
    -3500,
    -6000,
    -8000,
    3000,
    -2000,
  ];
  static final List<double> randomCoinOff = [
    100,
    300,
    400,
    800,
    1000,
    200,
    250,
  ];

  static double get trainOffset => randomOff[math.Random().nextInt(6)];

  static double get coinOffset => randomCoinOff[math.Random().nextInt(7)];
}
