import 'package:adventofcode2021/src/day.dart';

import 'helper/set_equals_extension.dart';
import 'helper/string_to_set_extension.dart';

class Day8 implements Day {
  @override
  int get dayNumber => 8;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final noteEntries =
        puzzleInput.split('\n').where((element) => element.isNotEmpty).map((e) => Note(e));

    var allOutputs = noteEntries.expand((element) => element.output);

    var onlySearchedOutputs = allOutputs.where((element) =>
        element.length == 2 || element.length == 3 || element.length == 4 || element.length == 7);

    return onlySearchedOutputs.length.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final noteEntries =
        puzzleInput.split('\n').where((element) => element.isNotEmpty).map((e) => Note(e)).toList();

    var sumOfOutputs =
        noteEntries.map((e) => e.integerOutput).reduce((value, element) => value + element);

    return sumOfOutputs.toString();
  }
}

class Note {
  late final List<Set<String>> signalPattern;
  late final List<Set<String>> output;
  late final int integerOutput;

  Note(String rawLine) {
    parseRawLine(rawLine);

    final signalPatternToIntegerMap = createSignalPatternToIntegerMap();

    calculateIntegerOutput(signalPatternToIntegerMap);
  }

  void parseRawLine(String rawLine) {
    var signalPatternAndOutput = rawLine.split('|').where((element) => element.isNotEmpty);

    signalPattern = signalPatternAndOutput.first
        .split(' ')
        .where((element) => element.isNotEmpty)
        .map((e) => e.toSet())
        .toList();

    output = signalPatternAndOutput.last
        .split(' ')
        .where((element) => element.isNotEmpty)
        .map((e) => e.toSet())
        .toList();
  }

  Map<Set<String>, int> createSignalPatternToIntegerMap() {
    Map<Set<String>, int> signalPatternToIntegerMap = {};

    var one = signalPattern.singleWhere((element) => element.length == 2);
    signalPatternToIntegerMap.putIfAbsent(one, () => 1);

    var four = signalPattern.singleWhere((element) => element.length == 4);
    signalPatternToIntegerMap.putIfAbsent(four, () => 4);

    var seven = signalPattern.singleWhere((element) => element.length == 3);
    signalPatternToIntegerMap.putIfAbsent(seven, () => 7);

    var eight = signalPattern.singleWhere((element) => element.length == 7);
    signalPatternToIntegerMap.putIfAbsent(eight, () => 8);

    var nine = signalPattern.singleWhere(
        (element) => element.length == 6 && element.difference(seven).difference(four).length == 1);
    signalPatternToIntegerMap.putIfAbsent(nine, () => 9);

    var six = signalPattern.singleWhere(
        (element) => element.length == 6 && element != nine && one.difference(element).length == 1);
    signalPatternToIntegerMap.putIfAbsent(six, () => 6);

    var zero = signalPattern
        .singleWhere((element) => element.length == 6 && element != nine && element != six);
    signalPatternToIntegerMap.putIfAbsent(zero, () => 0);

    var e = eight.difference(nine).single;
    var c = eight.difference(six).single;
    var f = one.difference({c}).single;

    var five = signalPattern.singleWhere(
        (element) => element.length == 5 && !element.contains(c) && !element.contains(e));
    signalPatternToIntegerMap.putIfAbsent(five, () => 5);

    var two = signalPattern.singleWhere((element) =>
        element.length == 5 && element != five && element.contains(c) && !element.contains(f));
    signalPatternToIntegerMap.putIfAbsent(two, () => 2);

    var three = signalPattern
        .singleWhere((element) => element.length == 5 && element != five && element != two);
    signalPatternToIntegerMap.putIfAbsent(three, () => 3);

    return signalPatternToIntegerMap;
  }

  void calculateIntegerOutput(Map<Set<String>, int> signalPatternToIntegerMap) {
    var stringOutput = '';

    for (var item in output) {
      var key = signalPatternToIntegerMap.keys.singleWhere((element) => element.equals(item));

      var digit = signalPatternToIntegerMap[key];

      stringOutput += digit.toString();
    }

    integerOutput = int.parse(stringOutput);
  }
}
