import 'package:adventofcode2021/src/day04.dart';
import 'package:test/test.dart';

void main() {
  group('day 4', () {
    final examplePuzzleInput =
        '''7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day4();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('4512'));
    });

    test('solveFirstPuzzle - column with winner - returns expected result', () {
      final puzzleInput = '''7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

 7 13 17 11  0
 4  2 23  4 24
 9  9 14 16  7
 5 10  3 18  5
11 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7''';
      final day = Day4();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('2266'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day4();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('1924'));
    });
  });
}
