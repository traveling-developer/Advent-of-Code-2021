import 'package:adventofcode2021/src/day07.dart';
import 'package:test/test.dart';

void main() {
  group('day 7', () {
    test('solveFirstPuzzle - example input - returns expected result', () {
      final puzzleInput = '''16,1,2,0,4,2,7,1,2,14''';
      final day = Day7();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('37'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final puzzleInput = '''16,1,2,0,4,2,7,1,2,14''';
      final day = Day7();

      final solution = day.solveSecondPuzzle(puzzleInput);

      expect(solution, equals('168'));
    });
  });
}
