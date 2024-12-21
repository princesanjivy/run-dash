import 'dart:math' as math;

bool isColliding(x1, y1, x2, y2, offset) {
  double dis = math.sqrt((math.pow((x2 - x1), 2)) + (math.pow((y2 - y1), 2)));
  return dis <= offset;
}
