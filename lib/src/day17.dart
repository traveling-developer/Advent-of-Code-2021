import 'dart:math';

import 'package:adventofcode2021/src/helper/tuple.dart';

import 'day.dart';

class Day17 implements Day {
  @override
  int get dayNumber => 17;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final targetArea = parseTargetAre(puzzleInput);

    var globalYMax = 0;

    for (var i = 1; i < 500; i++) {
      for (var j = 1; j < 500; j++) {
        var currentPosition = Point(0, 0);
        var xVelocity = j;
        var yVelocity = i;
        int currentMaxY = 0;

        while (currentPosition.x < targetArea.end.x && currentPosition.y > targetArea.start.y) {
          currentPosition.x += xVelocity;
          currentPosition.y += yVelocity;

          currentMaxY = max(currentMaxY, currentPosition.y);

          if (targetArea.containsPoint(currentPosition)) {
            globalYMax = max(currentMaxY, globalYMax);
            break;
          }

          xVelocity = calculateVerticalVelocity(xVelocity);
          yVelocity -= 1;

          if (xVelocity == 0 && currentPosition.x < targetArea.start.x) {
            break;
          }

          if (yVelocity < 0 && currentPosition.y < targetArea.start.y) {
            break;
          }
        }
      }
    }

    return globalYMax.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final targetArea = parseTargetAre(puzzleInput);

    List<Tuple<int, int>> validVelocities = [];

    for (var i = -500; i < 500; i++) {
      for (var j = -500; j < 500; j++) {
        var currentPosition = Point(0, 0);
        var xVelocity = j;
        var yVelocity = i;
        int currentMaxY = 0;

        while (currentPosition.x < targetArea.end.x && currentPosition.y > targetArea.start.y) {
          currentPosition.x += xVelocity;
          currentPosition.y += yVelocity;

          currentMaxY = max(currentMaxY, currentPosition.y);

          if (targetArea.containsPoint(currentPosition)) {
            validVelocities.add(Tuple(i, j));
            break;
          }

          xVelocity = calculateVerticalVelocity(xVelocity);
          yVelocity -= 1;

          if (xVelocity == 0 && currentPosition.x < targetArea.start.x) {
            break;
          }

          if (yVelocity < 0 && currentPosition.y < targetArea.start.y) {
            break;
          }
        }
      }
    }

    var distinctValidVelocities = validVelocities.toSet();

    return distinctValidVelocities.length.toString();
  }

  Area parseTargetAre(String puzzleInput) {
    final p = puzzleInput.split('x=').last.split(',');
    final xCoordinates = p.first.split('..').map((e) => int.parse(e));
    final yCoordinates = p.last.replaceAll(' y=', '').split('..').map((e) => int.parse(e));

    return Area(
        Point(xCoordinates.first, yCoordinates.first), Point(xCoordinates.last, yCoordinates.last));
  }

  int calculateVerticalVelocity(int velocity) {
    if (velocity == 0) {
      return 0;
    }

    if (velocity.isNegative) {
      return velocity + 1;
    }

    return velocity - 1;
  }
}

class Point {
  int x;
  int y;

  Point(this.x, this.y);
}

class Area {
  Point start;
  Point end;

  Area(this.start, this.end);

  bool containsPoint(Point point) {
    return point.x >= start.x && point.x <= end.x && point.y >= start.y && point.y <= end.y;
  }
}
