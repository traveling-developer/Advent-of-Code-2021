import 'package:adventofcode2021/src/advent_of_code_api.dart';
import 'package:adventofcode2021/src/day.dart';
import 'package:adventofcode2021/src/day01.dart';
import 'package:adventofcode2021/src/day02.dart';
import 'package:adventofcode2021/src/day03.dart';
import 'package:adventofcode2021/src/day04.dart';

Future<void> main(List<String> args) async {
  final adventOfCode = AdventOfCode(args[0]);
  await solveDay(Day4(), adventOfCode);
  await solveDay(Day3(), adventOfCode);
  await solveDay(Day2(), adventOfCode);
  await solveDay(Day1(), adventOfCode);
}

Future<void> solveDay(Day day, AdventOfCode adventOfCode) async {
  final puzzleInput = await adventOfCode.getPuzzleInputOfDay(day.dayNumber);

  print('Day ' + day.dayNumber.toString() + ' Solutions:');
  print('First puzzle Solution: ' + day.solveFirstPuzzle(puzzleInput));
  print('Second puzzle Solution: ' + day.solveSecondPuzzle(puzzleInput));
}
