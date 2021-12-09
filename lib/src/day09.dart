import 'package:adventofcode2021/src/helper/cell.dart';
import 'package:adventofcode2021/src/helper/table.dart';

import 'day.dart';

class Day9 implements Day {
  @override
  int get dayNumber => 9;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final heightmap = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => e.map((e) => int.parse(e)));

    var table = Table(heightmap);

    List<Cell<int>> lowPoints = findLowPoints(table);

    var sumOfRiskLevels =
        lowPoints.map((e) => e.value + 1).reduce((value, element) => value + element);

    return sumOfRiskLevels.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final heightmap = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => e.map((e) => int.parse(e)).toList())
        .toList();

    var table = Table(heightmap);

    List<Cell<int>> lowPoints = findLowPoints(table);

    List<int> basinsLength = [];

    for (var cell in lowPoints) {
      List<Cell<int>> basin = [];
      List<Cell<int>> cellsToVisit = [cell];

      while (cellsToVisit.isNotEmpty) {
        var cell = cellsToVisit.first;

        if (basin.contains(cell) || cell.value == 9) {
          cellsToVisit.remove(cell);
          continue;
        }

        basin.add(cell);
        cellsToVisit.remove(cell);
        var neighboursByCell = table.getNeighboursByCell(cell);
        cellsToVisit.addAll(neighboursByCell);
      }

      basinsLength.add(basin.length);
    }

    basinsLength.sort();
    return basinsLength.reversed.take(3).reduce((value, element) => value * element).toString();
  }

  List<Cell<int>> findLowPoints(Table<int> table) {
    List<Cell<int>> lowPoints = [];

    for (var cell in table.asIterableCells()) {
      var neigbhours = table.getNeighboursByCell(cell);

      if (neigbhours.every((element) => element.value > cell.value)) {
        lowPoints.add(cell);
      }
    }

    return lowPoints;
  }
}
