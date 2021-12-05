import 'dart:math';

import 'package:adventofcode2021/src/day05.dart';
import 'package:test/test.dart';

void main() {
  group('day 5', () {
    final examplePuzzleInput = '''0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day5();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('5'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day5();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('12'));
    });

    test('Line - example input - returns expected result', () {
      final line = Line('1,1 -> 3,3');

      expect(line.points,
          equals([const Point<num>(1, 1), const Point<num>(2, 2), const Point<num>(3, 3)]));
    });

    test('Line - second input - returns expected result', () {
      final line = Line('9,7 -> 7,9');

      expect(line.points,
          equals([const Point<num>(7, 9), const Point<num>(8, 8), const Point<num>(9, 7)]));
    });
  });
}
