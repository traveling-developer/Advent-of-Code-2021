import 'package:adventofcode2021/src/day.dart';

class Day10 implements Day {
  @override
  int get dayNumber => 10;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final lines = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => Line(e))
        .toList();

    var firstIllegalCharacters =
        lines.where((element) => element.isCorrupted).map((e) => e.wrongBrackets.first);

    var syntaxErrorScore = 0;

    for (var character in firstIllegalCharacters) {
      if (character == ')') {
        syntaxErrorScore += 3;
      }
      if (character == '}') {
        syntaxErrorScore += 1197;
      }
      if (character == ']') {
        syntaxErrorScore += 57;
      }
      if (character == '>') {
        syntaxErrorScore += 25137;
      }
    }

    return syntaxErrorScore.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final lines = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .map((e) => Line(e))
        .toList();

    var autocompletionScores = lines
        .where((element) => !element.isCorrupted)
        .map((e) => e.getAutocompletionScore())
        .toList();

    autocompletionScores.sort();

    var middleIndex = autocompletionScores.length ~/ 2;

    var middleScore = autocompletionScores[middleIndex];

    return middleScore.toString();
  }
}

class Line {
  final List<String> line;
  List<String> wrongBrackets = [];
  List<String> notClosedBrackets = [];

  Line(this.line) {
    for (var item in line) {
      if (item == '(' || item == '{' || item == '[' || item == '<') {
        notClosedBrackets.insert(0, item);
      }
      if (item == ')') {
        if (notClosedBrackets.first != '(') {
          wrongBrackets.add(item);
        }
        notClosedBrackets.removeAt(0);
      }
      if (item == '}') {
        if (notClosedBrackets.first != '{') {
          wrongBrackets.add(item);
        }
        notClosedBrackets.removeAt(0);
      }
      if (item == ']') {
        if (notClosedBrackets.first != '[') {
          wrongBrackets.add(item);
        }
        notClosedBrackets.removeAt(0);
      }
      if (item == '>') {
        if (notClosedBrackets.first != '<') {
          wrongBrackets.add(item);
        }
        notClosedBrackets.removeAt(0);
      }
    }
  }

  bool get isCorrupted => wrongBrackets.isNotEmpty;

  int getAutocompletionScore() {
    var score = 0;

    for (var bracket in notClosedBrackets) {
      score = score * 5;
      if (bracket == '(') {
        score += 1;
      }
      if (bracket == '{') {
        score += 3;
      }
      if (bracket == '[') {
        score += 2;
      }
      if (bracket == '<') {
        score += 4;
      }
    }

    return score;
  }
}
