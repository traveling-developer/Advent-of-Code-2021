import 'package:adventofcode2021/src/day02.dart';
import 'package:test/test.dart';

void main() {
  group('day 2', () {
    test('solveFirstPuzzle - example input - returns expected result', () {
      final puzzleInput = '''forward 5
down 5
forward 8
up 3
down 8
forward 2''';
      final day2 = Day2();

      final solution = day2.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('150'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final puzzleInput = '''forward 5
down 5
forward 8
up 3
down 8
forward 2''';
      final day2 = Day2();

      final solution = day2.solveSecondPuzzle(puzzleInput);

      expect(solution, equals('900'));
    });
  });
}
