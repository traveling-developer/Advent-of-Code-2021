import 'package:adventofcode2021/src/day11.dart';
import 'package:test/test.dart';

void main() {
  group('day 11', () {
    final examplePuzzleInput = '''5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day11();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('1656'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day11();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('195'));
    });
  });
}
