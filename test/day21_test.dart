import 'package:adventofcode2021/src/day21.dart';
import 'package:test/test.dart';

void main() {
  group('day 21', () {
    final examplePuzzleInput = '''Player 1 starting position: 4
Player 2 starting position: 8''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day21();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('739785'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day21();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('444356092776315'));
    });
  });
}
