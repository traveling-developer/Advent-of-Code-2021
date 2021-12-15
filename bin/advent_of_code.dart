import 'package:adventofcode2021/src/advent_of_code_api.dart';
import 'package:adventofcode2021/src/day.dart';
import 'package:adventofcode2021/src/day01.dart';
import 'package:adventofcode2021/src/day02.dart';
import 'package:adventofcode2021/src/day03.dart';
import 'package:adventofcode2021/src/day04.dart';
import 'package:adventofcode2021/src/day05.dart';
import 'package:adventofcode2021/src/day06.dart';
import 'package:adventofcode2021/src/day07.dart';
import 'package:adventofcode2021/src/day08.dart';
import 'package:adventofcode2021/src/day09.dart';
import 'package:adventofcode2021/src/day10.dart';
import 'package:adventofcode2021/src/day11.dart';
import 'package:adventofcode2021/src/day12.dart';
import 'package:adventofcode2021/src/day13.dart';
import 'package:adventofcode2021/src/day14.dart';
import 'package:adventofcode2021/src/day15.dart';

Future<void> main(List<String> args) async {
  final adventOfCode = AdventOfCode(args[0]);
  await solveDay(Day15(), adventOfCode);
  await solveDay(Day14(), adventOfCode);
  await solveDay(Day13(), adventOfCode);
  await solveDay(Day12(), adventOfCode);
  await solveDay(Day11(), adventOfCode);
  await solveDay(Day10(), adventOfCode);
  await solveDay(Day9(), adventOfCode);
  await solveDay(Day8(), adventOfCode);
  await solveDay(Day7(), adventOfCode);
  await solveDay(Day6(), adventOfCode);
  await solveDay(Day5(), adventOfCode);
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
