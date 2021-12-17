import 'package:adventofcode2021/src/day17.dart';
import 'package:test/test.dart';

void main() {
  group('day 17', () {
    final examplePuzzleInput = '''target area: x=20..30, y=-10..-5''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day17();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('45'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day17();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('112'));
    });
  });
}
