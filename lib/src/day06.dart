import 'package:adventofcode2021/src/day.dart';

class Day6 implements Day {
  @override
  int get dayNumber => 6;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final fish = parseFish(puzzleInput);

    for (var i = 0; i < 80; i++) {
      List<int> newFish = [];
      for (var i = 0; i < fish.length; i++) {
        var currentFishAge = fish[i];

        if (currentFishAge == 0) {
          newFish.add(8);
          fish[i] = 6;
        } else {
          fish[i] = currentFishAge - 1;
        }
      }
      fish.addAll(newFish);
    }

    return fish.length.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final fish = parseFish(puzzleInput);

    final numberOfFishPerAge = initializeFishPerAgeList(fish);

    for (var i = 0; i < 256; i++) {
      final spawnableFish = numberOfFishPerAge[0];

      for (var i = 0; i < 8; i++) {
        numberOfFishPerAge[i] = numberOfFishPerAge[i + 1];
      }

      numberOfFishPerAge[8] = spawnableFish;
      numberOfFishPerAge[6] += spawnableFish;
    }

    return numberOfFishPerAge.reduce((left, right) => left + right).toString();
  }

  List<int> initializeFishPerAgeList(List<int> fish) {
    var numberOfFishPerAge = List<int>.generate(9, (i) => 0);

    for (var fishAge in fish) {
      numberOfFishPerAge[fishAge] = numberOfFishPerAge[fishAge] + 1;
    }

    return numberOfFishPerAge;
  }

  List<int> parseFish(String puzzleInput) {
    final fish = puzzleInput
        .split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    return fish;
  }
}
