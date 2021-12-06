import 'package:adventofcode2021/src/day06.dart';
import 'package:test/test.dart';

void main() {
  group('day 6', () {
    test('solveFirstPuzzle - example input - returns expected result', () {
      final puzzleInput = '''3,4,3,1,2''';
      final day = Day6();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('5934'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final puzzleInput = '''3,4,3,1,2''';
      final day = Day6();

      final solution = day.solveSecondPuzzle(puzzleInput);

      expect(solution, equals('26984457539'));
    });
  });
}
