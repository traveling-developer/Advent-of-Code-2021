import 'package:adventofcode2021/src/day13.dart';
import 'package:test/test.dart';

void main() {
  group('day 13', () {
    final examplePuzzleInput = '''6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day13();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('17'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day13();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      var expectedSolution = '''\n[#, #, #, #, #]
[#, ., ., ., #]
[#, ., ., ., #]
[#, ., ., ., #]
[#, #, #, #, #]
[., ., ., ., .]
[., ., ., ., .]''';
      expect(solution, equals(expectedSolution));
    });
  });
}
