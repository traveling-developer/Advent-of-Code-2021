import 'package:adventofcode2021/src/day1.dart';
import 'package:test/test.dart';

void main() {
  group('day 1', () {
    test('solveFirstPuzzle - example input - returns expected result', () {
      final puzzleInput = '''199
200
208
210
200
207
240
269
260
263''';
      final day1 = Day1();

      final solution = day1.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('7'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final puzzleInput = '''199
200
208
210
200
207
240
269
260
263''';
      final day1 = Day1();

      final solution = day1.solveSecondPuzzle(puzzleInput);

      expect(solution, equals('5'));
    });
  });
}
