import 'package:adventofcode2021/src/day.dart';

class Day1 implements Day {
  @override
  String solveFirstPuzzle(String puzzleInput) {
    final parsedInput = parseInput(puzzleInput);

    int counter = countIncreases(parsedInput);

    return counter.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final parsedInput = parseInput(puzzleInput);

    List<int> windowedList = createWindowedList(parsedInput);

    int counter = countIncreases(windowedList);

    return counter.toString();
  }

  List<int> createWindowedList(List<int> parsedInput) {
    List<int> windowedList = [];

    for (var i = 0; i < parsedInput.length; i++) {
      if (i + 2 == parsedInput.length) {
        break;
      }
      var windowSum = parsedInput[i] + parsedInput[i + 1] + parsedInput[i + 2];
      windowedList.add(windowSum);
    }
    return windowedList;
  }

  List<int> parseInput(String puzzleInput) {
    final parsedInput = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return parsedInput;
  }

  int countIncreases(List<int> list) {
    int counter = 0;

    for (var i = 0; i < list.length; i++) {
      if (i + 1 == list.length) {
        break;
      }
      if (list[i] < list[i + 1]) {
        counter++;
      }
    }

    return counter;
  }
}
