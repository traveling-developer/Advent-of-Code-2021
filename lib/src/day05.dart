import 'dart:math';

import 'package:adventofcode2021/src/day.dart';
import 'package:collection/collection.dart';

import 'helper/compare_points_extension.dart';

class Day5 implements Day {
  @override
  int get dayNumber => 5;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final parsedInput = puzzleInput.split('\n').where((element) => element.isNotEmpty);

    final verticalAndHorizontalLines =
        parsedInput.map((e) => Line(e)).where((element) => !element.isDiagonal);

    var allPoints = verticalAndHorizontalLines.expand((element) => element.points);

    var groupedPoints = groupBy(allPoints, (Point point) => point);

    var numberOfDangerousAreas = 0;
    for (var item in groupedPoints.keys) {
      if (groupedPoints[item]!.length > 1) {
        numberOfDangerousAreas++;
      }
    }

    return numberOfDangerousAreas.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final parsedInput = puzzleInput.split('\n').where((element) => element.isNotEmpty);

    final allLines = parsedInput.map((e) => Line(e));

    var allPoints = allLines.expand((element) => element.points);

    var groupedPoints = groupBy(allPoints, (Point point) => point);

    var numberOfDangerousAreas = 0;
    for (var item in groupedPoints.keys) {
      if (groupedPoints[item]!.length > 1) {
        numberOfDangerousAreas++;
      }
    }

    return numberOfDangerousAreas.toString();
  }
}

class Line {
  late Point<num> startPoint;
  late Point<num> endPoint;
  List<Point> points = [];

  Line(String rawLine) {
    initializeStartAndEndPoint(rawLine);

    generateLine();
  }

  bool get isDiagonal => startPoint.x != endPoint.x && startPoint.y != endPoint.y;

  void initializeStartAndEndPoint(String rawLine) {
    final initialPoints = rawLine.split(' -> ').map((e) {
      var coordinates = e.split(',');
      return Point(num.parse(coordinates[0]), num.parse(coordinates[1]));
    }).toList();

    initialPoints.sort((a, b) => a.compareTo(b));

    startPoint = initialPoints.first;
    endPoint = initialPoints.last;
  }

  void generateLine() {
    if (startPoint.x == endPoint.x) {
      for (var i = startPoint.y; i <= endPoint.y; i++) {
        points.add(Point(startPoint.x, i));
      }
    } else if (startPoint.y == endPoint.y) {
      for (var i = startPoint.x; i <= endPoint.x; i++) {
        points.add(Point(i, startPoint.y));
      }
    } else {
      if (startPoint.y > endPoint.y) {
        int j = 0;
        for (var i = startPoint.x; i <= endPoint.x; i++) {
          points.add(Point(i, startPoint.y - j));
          j++;
        }
      } else {
        int j = 0;
        for (var i = startPoint.x; i <= endPoint.x; i++) {
          points.add(Point(i, startPoint.y + j));
          j++;
        }
      }
    }
  }
}
