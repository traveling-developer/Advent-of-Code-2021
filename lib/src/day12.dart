import 'package:adventofcode2021/src/day.dart';

class Day12 implements Day {
  @override
  int get dayNumber => 12;

  int numberOfPaths = 0;

  var startCave = 'start';
  var endCave = 'end';

  @override
  String solveFirstPuzzle(String puzzleInput) {
    Map<String, Set<String>> caveGraph = parseCaveGraph(puzzleInput);

    numberOfPaths = 0;

    countNumberOfPathsSimple(caveGraph, startCave, []);

    return numberOfPaths.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    Map<String, Set<String>> caveGraph = parseCaveGraph(puzzleInput);

    numberOfPaths = 0;

    countNumberOfPathsComplex(caveGraph, startCave, [], '');

    return numberOfPaths.toString();
  }

  Map<String, Set<String>> parseCaveGraph(String puzzleInput) {
    var rawConnections = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split('-').toSet())
        .toList();

    var distinctNodes = rawConnections.expand((element) => element).toSet();

    Map<String, Set<String>> caveGraph = {};

    for (var node in distinctNodes) {
      var connectedNodes = rawConnections
          .where((element) => element.contains(node))
          .expand((element) => element)
          .where((element) => element != node)
          .toSet();

      caveGraph.putIfAbsent(node, () => connectedNodes);
    }

    return caveGraph;
  }

  void countNumberOfPathsSimple(
      Map<String, Set<String>> caveGraph, String cave, List<String> visitedCaves) {
    if (isLowerCase(cave)) {
      visitedCaves.add(cave);
    }

    var neighbourCaves = caveGraph[cave]!;

    for (var item in neighbourCaves) {
      if (item == endCave) {
        numberOfPaths++;
      } else if (!visitedCaves.contains(item)) {
        countNumberOfPathsSimple(caveGraph, item, visitedCaves.toList());
      }
    }
  }

  void countNumberOfPathsComplex(Map<String, Set<String>> caveGraph, String cave,
      List<String> visitedCaves, String revisitingCave) {
    if (isLowerCase(cave)) {
      visitedCaves.add(cave);
    }

    var neighbourCaves = caveGraph[cave]!;

    for (var item in neighbourCaves) {
      if (item == endCave) {
        numberOfPaths++;
      } else {
        final wasAlreadyVisited = visitedCaves.contains(item);

        if (wasAlreadyVisited && revisitingCave.isEmpty && item != startCave) {
          countNumberOfPathsComplex(caveGraph, item, [...visitedCaves], item);
        } else if (!wasAlreadyVisited && item != revisitingCave) {
          countNumberOfPathsComplex(caveGraph, item, [...visitedCaves], revisitingCave);
        }
      }
    }
  }

  bool isLowerCase(String cave) => cave == cave.toLowerCase();
}
