import 'dart:math';

extension CompareTo on Point {
  int compareTo(Point b) {
    var xCompared = x.compareTo(b.x);
    if (xCompared != 0) {
      return xCompared;
    }
    return y.compareTo(b.y);
  }
}
