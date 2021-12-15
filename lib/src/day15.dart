import 'dart:math';

import 'package:adventofcode2021/src/helper/int_max.dart';
import 'package:adventofcode2021/src/helper/table.dart';
import 'package:adventofcode2021/src/helper/tuple.dart';
import 'package:collection/collection.dart';

import 'day.dart';

class Day15 implements Day {
  @override
  int get dayNumber => 15;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    var rawRiskLevelMap = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split('').map((e) => int.parse(e)));

    var lowestRisk = findLowestRisk(rawRiskLevelMap);

    return lowestRisk.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    var rawRiskLevelMap = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split('').map((e) => int.parse(e)));

    var scaledInput = scaleRiskLevelMap(rawRiskLevelMap);

    var lowestRisk = findLowestRisk(scaledInput);

    return lowestRisk.toString();
  }

  int findLowestRisk(Iterable<Iterable<int>> rawRiskLevelMap) {
    Map<Point, int> riskLevelMap = {};

    for (var i = 0; i < rawRiskLevelMap.length; i++) {
      for (var j = 0; j < rawRiskLevelMap.first.length; j++) {
        riskLevelMap.putIfAbsent(Point(j, i), () => rawRiskLevelMap.elementAt(i).elementAt(j));
      }
    }

    var startPoint = const Point(0, 0);
    var goalPoint = Point(rawRiskLevelMap.length - 1, rawRiskLevelMap.first.length - 1);

    var queue = PriorityQueue<Tuple<Point, int>>((a, b) => a.secondItem.compareTo(b.secondItem));
    queue.add(Tuple(startPoint, 0));

    Map<Point, int> lowestRiskPathMap = {};
    lowestRiskPathMap[startPoint] = 0;

    while (queue.isNotEmpty) {
      var currentPoint = queue.removeFirst();

      if (currentPoint.firstItem == goalPoint) {
        return currentPoint.secondItem;
      }

      var neighbourPoints = getNeighbourPoints(currentPoint.firstItem);
      for (var neighbour in neighbourPoints) {
        if (riskLevelMap.containsKey(neighbour)) {
          var totalRiskViaNeighbour =
              lowestRiskPathMap[currentPoint.firstItem]! + riskLevelMap[neighbour]!;
          if (totalRiskViaNeighbour < (lowestRiskPathMap[neighbour] ?? intMax64)) {
            lowestRiskPathMap[neighbour] = totalRiskViaNeighbour;
            queue.add(Tuple(neighbour, totalRiskViaNeighbour));
          }
        }
      }
    }

    return intMax64;
  }

  int solve(Table<int> table) {
    Map<Point, int> riskMap = {};

    for (var cell in table.asIterableCells()) {
      riskMap.putIfAbsent(Point(cell.x, cell.y), () => cell.value);
    }

    var start = Point(0, 0);
    var end = Point(table.columnsLength - 1, table.rowLength - 1);

    var queue = PriorityQueue<Tuple<Point, int>>((a, b) => a.secondItem.compareTo(b.secondItem));
    var lowestRiskPathMap = <Point, int>{};
    lowestRiskPathMap[start] = 0;
    queue.add(Tuple(start, 0));

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current.firstItem == end) {
        return current.secondItem;
      }

      var neig = getNeighbourPoints(current.firstItem);

      for (var item in neig) {
        if (riskMap.containsKey(item)) {
          var totalRiskMap2 = lowestRiskPathMap[current.firstItem]!;
          var riskMap2 = riskMap[item]!;
          var totalRiskThroughP = totalRiskMap2 + riskMap2;
          var object = lowestRiskPathMap[item] ?? intMax64;
          if (totalRiskThroughP < object) {
            lowestRiskPathMap[item] = totalRiskThroughP;
            queue.add(Tuple(item, totalRiskThroughP));
          }
        }
      }
    }
    return 0;
  }

  List<Point<num>> getNeighbourPoints(Point<num> firstItem) {
    List<Point<num>> neighbourPoints = [];

    neighbourPoints.add(Point(firstItem.x + 1, firstItem.y));
    neighbourPoints.add(Point(firstItem.x - 1, firstItem.y));
    neighbourPoints.add(Point(firstItem.x, firstItem.y + 1));
    neighbourPoints.add(Point(firstItem.x, firstItem.y - 1));

    return neighbourPoints;
  }

  Iterable<Iterable<int>> scaleRiskLevelMap(Iterable<Iterable<int>> rawRiskLevelMap) {
    var scaledToRight = addToRight(rawRiskLevelMap, rawRiskLevelMap, 1);
    scaledToRight = addToRight(scaledToRight, rawRiskLevelMap, 2);
    scaledToRight = addToRight(scaledToRight, rawRiskLevelMap, 3);
    scaledToRight = addToRight(scaledToRight, rawRiskLevelMap, 4);

    var scaledToBottom = addToBottom(scaledToRight, scaledToRight, 1);
    scaledToBottom = addToBottom(scaledToBottom, scaledToRight, 2);
    scaledToBottom = addToBottom(scaledToBottom, scaledToRight, 3);
    scaledToBottom = addToBottom(scaledToBottom, scaledToRight, 4);

    return scaledToBottom;
  }

  List<List<int>> addToRight(
      Iterable<Iterable<int>> original, Iterable<Iterable<int>> toBeAdded, int scaleFactor) {
    List<List<int>> newRawTable = [];

    for (var i = 0; i < original.length; i++) {
      List<int> row = [];
      for (var j = 0; j < original.first.length; j++) {
        row.add(original.elementAt(i).elementAt(j));
      }
      for (var j = 0; j < toBeAdded.first.length; j++) {
        row.add(riskTransformation(toBeAdded.elementAt(i).elementAt(j), scaleFactor));
      }
      newRawTable.add(row);
    }

    return newRawTable;
  }

  List<List<int>> addToBottom(
      Iterable<Iterable<int>> original, Iterable<Iterable<int>> toBeAdded, int scaleFactor) {
    List<List<int>> newRawTable = [];

    for (var i = 0; i < original.length; i++) {
      List<int> row = [];
      for (var j = 0; j < original.first.length; j++) {
        row.add(original.elementAt(i).elementAt(j));
      }
      newRawTable.add(row);
    }

    for (var i = 0; i < toBeAdded.length; i++) {
      List<int> row = [];
      for (var j = 0; j < toBeAdded.first.length; j++) {
        row.add(riskTransformation(toBeAdded.elementAt(i).elementAt(j), scaleFactor));
      }
      newRawTable.add(row);
    }

    return newRawTable;
  }

  int riskTransformation(int riskValue, int transformationFactor) {
    var newValue = riskValue + transformationFactor;

    if (newValue % 9 == 0) {
      return 9;
    }

    return newValue % 9;
  }
}
