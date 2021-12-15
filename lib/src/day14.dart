import 'dart:math';

import 'package:adventofcode2021/src/helper/tuple.dart';

import 'day.dart';

class Day14 implements Day {
  @override
  int get dayNumber => 14;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    var polymerTemplateAndPairInsertions =
        puzzleInput.split('\n\n').where((element) => element.isNotEmpty);

    var polymerTemplate = polymerTemplateAndPairInsertions.first;

    var pairInsertions = parsePairInsertions(polymerTemplateAndPairInsertions);

    var pairInsertionMappings = createPairInsertionMappings(pairInsertions);

    Map<String, int> polymerMap = initializePolymerMap(polymerTemplate);

    polymerMap = processPolymer(polymerMap, pairInsertionMappings, 10);

    var result = calculateResult(polymerMap);

    return result.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    var polymerTemplateAndPairInsertions =
        puzzleInput.split('\n\n').where((element) => element.isNotEmpty);

    var polymerTemplate = polymerTemplateAndPairInsertions.first;

    var pairInsertions = parsePairInsertions(polymerTemplateAndPairInsertions);

    var pairInsertionMappings = createPairInsertionMappings(pairInsertions);

    Map<String, int> polymerMap = initializePolymerMap(polymerTemplate);

    polymerMap = processPolymer(polymerMap, pairInsertionMappings, 40);

    var result = calculateResult(polymerMap);

    return result.toString();
  }

  Iterable<Tuple<String, String>> parsePairInsertions(
      Iterable<String> polymerTemplateAndPairInsertions) {
    var pairInsertions = polymerTemplateAndPairInsertions.last
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) {
      var pairInsertion = e.split(' -> ');
      return Tuple(pairInsertion.first, pairInsertion.last);
    });
    return pairInsertions;
  }

  Map<String, Tuple<String, String>> createPairInsertionMappings(
      Iterable<Tuple<String, String>> pairInsertions) {
    Map<String, Tuple<String, String>> pairInsertionMappings = {};

    for (var rule in pairInsertions) {
      pairInsertionMappings[rule.firstItem] =
          Tuple(rule.firstItem[0] + rule.secondItem, rule.secondItem + rule.firstItem[1]);
    }
    return pairInsertionMappings;
  }

  Map<String, int> initializePolymerMap(String parsed) {
    Map<String, int> polymerMap = {};

    for (var i = 0; i < parsed.length - 1; i++) {
      var subPolymer = parsed[i] + parsed[i + 1];

      polymerMap[subPolymer] = (polymerMap[subPolymer] ?? 0) + 1;
    }

    return polymerMap;
  }

  Map<String, int> processPolymer(Map<String, int> polymerMap,
      Map<String, Tuple<String, String>> pairInsertionMappings, int numberOfSteps) {
    for (var i = 0; i < numberOfSteps; i++) {
      Map<String, int> newPolymer = {};

      for (var pair in polymerMap.keys) {
        var newPairs = pairInsertionMappings[pair]!;

        var pairCount = polymerMap[pair]!;

        newPolymer[newPairs.firstItem] = (newPolymer[newPairs.firstItem] ?? 0) + 1 * pairCount;
        newPolymer[newPairs.secondItem] = (newPolymer[newPairs.secondItem] ?? 0) + 1 * pairCount;
      }

      polymerMap = newPolymer;
    }

    return polymerMap;
  }

  int calculateResult(Map<String, int> polymerMap) {
    Map<String, int> characterCounts = {};

    for (var item in polymerMap.keys) {
      var pairCount = polymerMap[item]!;

      characterCounts[item[0]] = (characterCounts[item[0]] ?? 0) + pairCount;
      characterCounts[item[1]] = (characterCounts[item[1]] ?? 0) + pairCount;
    }

    var counts = characterCounts.entries.map((e) => (e.value ~/ 2) + 1);

    var maximumCount = counts.reduce(max);
    var minimumCount = counts.reduce(min);

    var result = (maximumCount - minimumCount) + 1;

    return result;
  }
}
