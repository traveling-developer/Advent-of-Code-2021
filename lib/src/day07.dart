import 'dart:math';

import 'package:adventofcode2021/src/day.dart';
import 'package:collection/collection.dart';

class Day7 implements Day {
  @override
  int get dayNumber => 7;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final crabs = parseCrabs(puzzleInput);

    var cheapestFuelCost = calculateCheapestFuelCost(crabs, constantFuelCost);

    return cheapestFuelCost.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final crabs = parseCrabs(puzzleInput);

    var cheapestFuelCost = calculateCheapestFuelCost(crabs, linearFuelCost);

    return cheapestFuelCost.toString();
  }

  List<int> parseCrabs(String puzzleInput) {
    final crabs = puzzleInput
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return crabs;
  }

  int calculateCheapestFuelCost(List<int> crabs, int Function(int, int) calculateFuelCost) {
    var minimalCrabPosition = crabs.reduce(min);
    var maximalCrabPosition = crabs.reduce(max);

    List<int> allFuelCosts = [];

    for (var i = minimalCrabPosition; i <= maximalCrabPosition; i++) {
      int fuelCost = 0;

      for (var crab in crabs) {
        fuelCost += calculateFuelCost(crab, i);
      }
      allFuelCosts.add(fuelCost);
    }

    return allFuelCosts.reduce(min);
  }

  int constantFuelCost(int crabPosition, int goalPosition) {
    return (crabPosition - goalPosition).abs();
  }

  int linearFuelCost(int crabPosition, int goalPosition) {
    var steps = (crabPosition - goalPosition).abs();
    return List<int>.generate(steps, (i) => i + 1).sum;
  }
}
