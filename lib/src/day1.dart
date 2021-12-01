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

    List<int> windowedList = generateWindowedList(parsedInput);

    int counter = countIncreases(windowedList);

    return counter.toString();
  }

  List<int> parseInput(String puzzleInput) {
    final list = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return list;
  }

  int countIncreases(List<int> list) {
    var counter = 0;

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

  List<int> generateWindowedList(List<int> list) {
    List<int> windowedList = [];

    for (var i = 0; i < list.length; i++) {
      if (i + 2 == list.length) {
        break;
      }
      var sum = list[i] + list[i + 1] + list[i + 2];
      windowedList.add(sum);
    }

    return windowedList;
  }
}
