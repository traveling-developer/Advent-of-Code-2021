import 'package:adventofcode2021/src/advent_of_code_api.dart';
import 'package:adventofcode2021/src/day1.dart';

Future<void> main(List<String> args) async {
  final adventOfCode = AdventOfCode(args[0]);
  final day1 = Day1();
  final day1Puzzle = await adventOfCode.getPuzzleInputOfDay(1);

  print(day1.firstPuzzle(day1Puzzle));
}
