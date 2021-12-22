import 'package:adventofcode2021/src/day20.dart';
import 'package:test/test.dart';

void main() {
  group('day 20', () {
    final examplePuzzleInput =
        '''..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###''';

    test('solveFirstPuzzle - example input - returns expected result', () {
      final day = Day20();

      final solution = day.solveFirstPuzzle(examplePuzzleInput);

      expect(solution, equals('35'));
    });

    test('solveSecondPuzzle - example input - returns expected result', () {
      final day = Day20();

      final solution = day.solveSecondPuzzle(examplePuzzleInput);

      expect(solution, equals('3351'));
    });
  });
}
