import 'dart:math';

import 'package:adventofcode2021/src/day.dart';
import 'package:adventofcode2021/src/helper/cell.dart';
import 'package:adventofcode2021/src/helper/table.dart';
import 'package:adventofcode2021/src/helper/tuple.dart';

class Day13 implements Day {
  @override
  int get dayNumber => 13;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    var dotsAndInstructions = puzzleInput.split('\n\n');
    var instructions = parseInstructions(dotsAndInstructions.last);
    var table = parseDotsAsTable(dotsAndInstructions.first);

    var instruction = instructions.first;

    if (instruction.firstItem == 'y') {
      table = foldHorizontal(table, instruction.secondItem);
    }

    if (instruction.firstItem == 'x') {
      table = foldVertical(table, instruction.secondItem);
    }

    int numberOfDots =
        table.cells.expand((element) => element).where((element) => element.value == '#').length;

    return numberOfDots.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    var dotsAndInstructions = puzzleInput.split('\n\n');
    var instructions = parseInstructions(dotsAndInstructions.last);
    var table = parseDotsAsTable(dotsAndInstructions.first);

    for (var instruction in instructions) {
      if (instruction.firstItem == 'y') {
        table = foldHorizontal(table, instruction.secondItem);
      }

      if (instruction.firstItem == 'x') {
        table = foldVertical(table, instruction.secondItem);
      }
    }

    return table.toString();
  }

  void overlapLinesVertical(List<Cell<String>> left, List<Cell<String>> right) {
    for (var i = 0; i < left.length; i++) {
      var leftCell = left[i];
      var rightCell = right[right.length - 1 - i];

      if (rightCell.value == '#') {
        leftCell.value = '#';
        rightCell.value = '.';
      }
    }
  }

  List<Tuple<String, int>> parseInstructions(String rawInstructions) {
    return rawInstructions.split('\n').where((element) => element.isNotEmpty).map((e) {
      var instructionParts = e.split('=');

      var line = int.parse(instructionParts.last);
      var direction = instructionParts.first.split('').last;

      return Tuple(direction, line);
    }).toList();
  }

  Table<String> parseDotsAsTable(String rawDots) {
    var parsedDots = rawDots.split('\n').map((e) {
      var coordinates = e.split(',');
      return Tuple(int.parse(coordinates.first), int.parse(coordinates.last));
    });

    var rowSize = parsedDots.map((e) => e.secondItem).reduce(max) + 1;
    var columnSize = parsedDots.map((e) => e.firstItem).reduce(max) + 1;

    var table =
        Table(List.generate(rowSize, (index) => List<String>.generate(columnSize, (index) => '.')));

    for (var dot in parsedDots) {
      table.setValue(dot.secondItem, dot.firstItem, '#');
    }

    return table;
  }

  Table<String> foldHorizontal(Table<String> table, int index) {
    var splittedTable = table.splitHorizontal(index);

    var upperPart = splittedTable.first;
    var lowerPart = splittedTable.last;

    for (var i = 0; i < upperPart.rowLength; i++) {
      var lowRow = lowerPart.cells[i];
      var upRow = upperPart.cells[upperPart.cells.length - 1 - i];

      for (var i = 0; i < upRow.length; i++) {
        var upCell = upRow[i];
        var lowCell = lowRow[i];

        if (lowCell.value == '#') {
          upCell.value = '#';
        }
      }
    }

    return upperPart;
  }

  Table<String> foldVertical(Table<String> table, int index) {
    var splittedTable = table.splitVertical(index);

    var leftPart = splittedTable.first;
    var rightPart = splittedTable.last;

    for (var i = 0; i < leftPart.rowLength; i++) {
      var rightRow = rightPart.cells[i];
      var leftRow = leftPart.cells[i];

      for (var i = 0; i < leftRow.length; i++) {
        var leftCell = leftRow[i];
        var rightCell = rightRow[rightRow.length - 1 - i];

        if (rightCell.value == '#') {
          leftCell.value = '#';
        }
      }
    }

    return leftPart;
  }
}
