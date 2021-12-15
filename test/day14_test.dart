import 'package:adventofcode2021/src/day14.dart';
import 'package:test/test.dart';

void main() {
  group('day 14', () {
    final examplePuzzleInput = '''NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day14();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('1588'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day14();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('2188189693529'));
    });
  });
}
