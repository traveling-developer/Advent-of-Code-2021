import 'package:adventofcode2021/src/day09.dart';
import 'package:test/test.dart';

void main() {
  group('day 9', () {
    final examplePuzzleInput = '''2199943210
3987894921
9856789892
8767896789
9899965678''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day9();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('15'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day9();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('1134'));
    });
  });
}
