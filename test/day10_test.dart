import 'package:adventofcode2021/src/day10.dart';
import 'package:test/test.dart';

void main() {
  group('day 10', () {
    final examplePuzzleInput = '''[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day10();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('26397'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day10();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('288957'));
    });
  });
}
