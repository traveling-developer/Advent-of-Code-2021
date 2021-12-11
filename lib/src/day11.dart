import 'day.dart';
import 'helper/cell.dart';
import 'helper/table.dart';

class Day11 implements Day {
  @override
  int get dayNumber => 11;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final octopuses = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => e.map((e) => int.parse(e)));

    var table = Table(octopuses);
    int numberOfFlashes = 0;

    for (var i = 0; i < 100; i++) {
      numberOfFlashes += updateOctopusesForOneStep(table);
    }

    return numberOfFlashes.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final octopuses = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => e.map((e) => int.parse(e)));

    var table = Table(octopuses);

    var numberOfSteps = 0;
    do {
      updateOctopusesForOneStep(table);
      numberOfSteps++;
    } while (!table.asIterableCells().every((element) => element.value == 0));

    return numberOfSteps.toString();
  }

  int updateOctopusesForOneStep(Table<int> table) {
    var numberOfFlashes = 0;

    for (var octopus in table.asIterableCells()) {
      octopus.value = octopus.value + 1;
    }

    do {
      var flashingOctopuses = table.asIterableCells().where(isFlashing);

      for (var octopus in flashingOctopuses) {
        table.getAllNeighbours(octopus.y, octopus.x).forEach((element) {
          if (element.value != 0) {
            element.value = element.value + 1;
          }
        });
        octopus.value = 0;
        numberOfFlashes++;
      }
    } while (table.asIterableCells().where(isFlashing).isNotEmpty);

    return numberOfFlashes;
  }

  bool isFlashing(Cell<int> element) => element.value > 9;
}
