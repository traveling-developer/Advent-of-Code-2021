import 'package:adventofcode2021/src/advent_of_code_api.dart';
import 'package:adventofcode2021/src/day01.dart';
import 'package:adventofcode2021/src/day02.dart';
import 'package:adventofcode2021/src/day03.dart';

Future<void> main(List<String> args) async {
  final adventOfCode = AdventOfCode(args[0]);
  await solveDay3(adventOfCode);
  await solveDay2(adventOfCode);
  await solveDay1(adventOfCode);
}

Future<void> solveDay3(AdventOfCode adventOfCode) async {
  final day = Day3();
  final puzzleInput = await adventOfCode.getPuzzleInputOfDay(3);

  print('Day 3 Solutions:');
  print('First puzzle Solution: ' + day.solveFirstPuzzle(puzzleInput));
  print('Second puzzle Solution: ' + day.solveSecondPuzzle(puzzleInput));
}

Future<void> solveDay2(AdventOfCode adventOfCode) async {
  final day = Day2();
  final puzzleInput = await adventOfCode.getPuzzleInputOfDay(2);

  print('Day 2 Solutions:');
  print('First puzzle Solution: ' + day.solveFirstPuzzle(puzzleInput));
  print('Second puzzle Solution: ' + day.solveSecondPuzzle(puzzleInput));
}

Future<void> solveDay1(AdventOfCode adventOfCode) async {
  final day = Day1();
  final puzzleInput = await adventOfCode.getPuzzleInputOfDay(1);

  print('Day 1 Solutions:');
  print('First puzzle Solution: ' + day.solveFirstPuzzle(puzzleInput));
  print('Second puzzle Solution: ' + day.solveSecondPuzzle(puzzleInput));
}
