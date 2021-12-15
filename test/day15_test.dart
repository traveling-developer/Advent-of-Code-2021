import 'package:adventofcode2021/src/day15.dart';
import 'package:test/test.dart';

void main() {
  group('day 15', () {
    final examplePuzzleInput = '''1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day15();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('40'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day15();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('315'));
    });
  });
}
