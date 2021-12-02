import 'package:adventofcode2021/src/day.dart';

class Day2 implements Day {
  final String forward = 'forward';
  final String down = 'down';
  final String up = 'up';

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final commands = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => createCommand(e))
        .toList();

    var position = Position();

    for (var command in commands) {
      if (command.direction == forward) {
        position.horizontal += command.amount;
      }
      if (command.direction == down) {
        position.depth += command.amount;
      }
      if (command.direction == up) {
        position.depth -= command.amount;
      }
    }

    int puzzleSolution = position.horizontal * position.depth;
    return puzzleSolution.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final commands = puzzleInput
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => createCommand(e))
        .toList();

    var position = Position();

    for (var command in commands) {
      if (command.direction == forward) {
        position.horizontal += command.amount;
        position.depth += position.aim * command.amount;
      }
      if (command.direction == down) {
        position.aim += command.amount;
      }
      if (command.direction == up) {
        position.aim -= command.amount;
      }
    }

    int puzzleSolution = position.horizontal * position.depth;
    return puzzleSolution.toString();
  }

  Command createCommand(String command) {
    var commandParts = command.split(' ');
    return Command(commandParts[0], int.parse(commandParts[1]));
  }
}

class Command {
  final String direction;
  final int amount;

  Command(this.direction, this.amount);
}

class Position {
  int horizontal = 0;
  int depth = 0;
  int aim = 0;
}
