import 'package:adventofcode2021/src/day03.dart';
import 'package:test/test.dart';

void main() {
  group('day 3', () {
    test('solveFirstPuzzle - example input - returns expected result', () {
      final puzzleInput = '''00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010''';
      final day = Day3();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('198'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final puzzleInput = '''00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010''';
      final day = Day3();

      final solution = day.solveSecondPuzzle(puzzleInput);

      expect(solution, equals('230'));
    });
  });
}
