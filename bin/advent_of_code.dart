import 'package:adventofcode2021/src/advent_of_code_api.dart';
import 'package:adventofcode2021/src/day02.dart';
import 'package:adventofcode2021/src/day1.dart';

Future<void> main(List<String> args) async {
  final adventOfCode = AdventOfCode(args[0]);
  await solveDay1(adventOfCode);
  await solveDay2(adventOfCode);
}

Future<void> solveDay1(AdventOfCode adventOfCode) async {
  final day1 = Day1();
  final day1Puzzle = await adventOfCode.getPuzzleInputOfDay(1);

  print('Day 1 Solutions:');
  print('First puzzle Solution: ' + day1.solveFirstPuzzle(day1Puzzle));
  print('Second puzzle Solution: ' + day1.solveSecondPuzzle(day1Puzzle));
}

Future<void> solveDay2(AdventOfCode adventOfCode) async {
  final day2 = Day2();
  final day2Puzzle = await adventOfCode.getPuzzleInputOfDay(2);

  print('Day 2 Solutions:');
  print('First puzzle Solution: ' + day2.solveFirstPuzzle(day2Puzzle));
  print('Second puzzle Solution: ' + day2.solveSecondPuzzle(day2Puzzle));
}
