import 'dart:math';

import 'package:adventofcode2021/src/helper/tuple.dart';
import 'package:quiver/core.dart';

import 'day.dart';

class Day21 implements Day {
  @override
  int get dayNumber => 21;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    var playersStartingPosition =
        puzzleInput.split('\n').where((element) => element.isNotEmpty).map((e) => e[e.length - 1]);

    var die = DeterministicDie();
    var firstPlayer = Player(int.parse(playersStartingPosition.first), 0);
    var secondPlayer = Player(int.parse(playersStartingPosition.last), 0);

    var currentPlayer = firstPlayer;

    do {
      currentPlayer.moveDeterministic(die.roll() + die.roll() + die.roll());
      if (currentPlayer.hasWonDeterministic()) {
        break;
      }

      if (currentPlayer == firstPlayer) {
        currentPlayer = secondPlayer;
      } else {
        currentPlayer = firstPlayer;
      }
    } while (true);

    int result = 0;

    if (currentPlayer == firstPlayer) {
      result = secondPlayer.score * die.timesRolled;
    } else {
      result = firstPlayer.score * die.timesRolled;
    }

    return result.toString();
  }

  Map<Tuple<Player, Player>, Tuple<int, int>> gamesCache = {};

  @override
  String solveSecondPuzzle(String puzzleInput) {
    var playersStartingPosition =
        puzzleInput.split('\n').where((element) => element.isNotEmpty).map((e) => e[e.length - 1]);

    var firstPlayer = Player(int.parse(playersStartingPosition.first), 0);
    var secondPlayer = Player(int.parse(playersStartingPosition.last), 0);

    var winsPerPlayer = playGamesInUniverses(Tuple(firstPlayer, secondPlayer));

    var maximalWins = max(winsPerPlayer.firstItem, winsPerPlayer.secondItem);

    return maximalWins.toString();
  }

  Tuple<int, int> playGamesInUniverses(Tuple<Player, Player> players) {
    if (players.secondItem.hasWonDirac()) {
      return Tuple(0, 1);
    }

    if (!gamesCache.containsKey(players)) {
      var winsPerPlayer = Tuple(0, 0);
      for (var item in getDiracThrows()) {
        var playedGames = playGamesInUniverses(
            Tuple(players.secondItem, createMovedPlayer(players.firstItem, item)));

        winsPerPlayer.firstItem += playedGames.secondItem;
        winsPerPlayer.secondItem += playedGames.firstItem;
      }

      gamesCache[players] = winsPerPlayer;
    }

    return gamesCache[players]!;
  }

  List<int> getDiracThrows() {
    var list = <int>[];
    for (var i in List.generate(3, (index) => index + 1)) {
      for (var j in List.generate(3, (index) => index + 1)) {
        for (var k in List.generate(3, (index) => index + 1)) {
          list.add(i + j + k);
        }
      }
    }

    return list;
  }

  Player createMovedPlayer(Player player, int steps) {
    var newPosition = (player.position + steps) % 10;

    if (newPosition == 0) {
      newPosition = 10;
    }
    return Player(newPosition, player.score + newPosition);
  }
}

class Player {
  int position;
  int score;

  Player(this.position, this.score);

  void moveDeterministic(int steps) {
    position = (position + steps) % 10;
    if (position == 0) {
      position = 10;
    }
    score += position;
  }

  bool hasWonDeterministic() => score >= 1000;
  bool hasWonDirac() => score >= 21;

  @override
  int get hashCode => hash2(position, score);

  @override
  bool operator ==(Object other) =>
      other is Player && other.position == position && other.score == score;
}

class DeterministicDie {
  int _next = 0;
  int timesRolled = 0;

  int roll() {
    _next++;

    if (_next > 100) {
      _next = 1;
    }

    timesRolled++;

    return _next;
  }
}
