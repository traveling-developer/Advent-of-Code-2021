import 'package:adventofcode2021/src/day.dart';
import 'package:quiver/iterables.dart';

import 'helper/columns_of_iterable_extension.dart';
import 'helper/tuple.dart';

class Day4 implements Day {
  @override
  int get dayNumber => 4;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final parsedInput = puzzleInput.split('\n').where((element) => element.isNotEmpty).toList();
    List<String> chosenNumbers = extractChosenNumbers(parsedInput);

    final rawBoards = partition(parsedInput, 5);
    final boards = rawBoards.map((e) => Board(e)).toList();

    for (var value in chosenNumbers) {
      for (var board in boards) {
        board.markValue(value);
      }

      if (boards.any((element) => element.hasWon())) {
        var winner = boards.singleWhere((element) => element.hasWon());
        var solution = winner.sumOfAllUnmarked() * int.parse(value);

        return solution.toString();
      }
    }

    return 'No solution were found';
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final parsedInput = puzzleInput.split('\n').where((element) => element.isNotEmpty).toList();
    List<String> chosenNumbers = extractChosenNumbers(parsedInput);

    final rawBoards = partition(parsedInput, 5);
    final boards = rawBoards.map((e) => Board(e)).toList();

    for (var value in chosenNumbers) {
      for (var board in boards) {
        board.markValue(value);
      }

      if (boards.any((element) => element.hasWon())) {
        if (boards.length == 1) {
          var solution = boards.first.sumOfAllUnmarked() * int.parse(value);

          return solution.toString();
        } else {
          var allWinner = boards.where((element) => element.hasWon()).toList();
          for (var winner in allWinner) {
            boards.remove(winner);
          }
        }
      }
    }

    return 'No solution were found';
  }

  List<String> extractChosenNumbers(List<String> input) {
    final chosenNumbers = input.first.split(',');

    input.removeAt(0);

    return chosenNumbers;
  }
}

class Board {
  late List<List<Tuple<String, bool>>> fields;

  Board(List<String> fieldsAsList) {
    fields = fieldsAsList
        .map((e) => e.split(' '))
        .map((e) =>
            e.map((e) => Tuple(e, false)).where((element) => element.firstItem.isNotEmpty).toList())
        .toList();
  }

  void markValue(String value) {
    for (var row in fields) {
      for (var item in row) {
        if (item.firstItem == value) {
          item.secondItem = true;
        }
      }
    }
  }

  bool hasWon() {
    for (var row in fields) {
      if (row.every((element) => element.secondItem == true)) {
        return true;
      }
    }

    for (var column in fields.getColumns()) {
      if (column.every((element) => element.secondItem == true)) {
        return true;
      }
    }
    return false;
  }

  int sumOfAllUnmarked() {
    final sum = fields
        .expand((element) => element)
        .where((element) => element.secondItem == false)
        .map((e) => int.parse(e.firstItem))
        .reduce((value, element) => value + element);

    return sum;
  }
}
