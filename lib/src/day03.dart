import 'package:adventofcode2021/src/day.dart';

class Day3 implements Day {
  @override
  int get dayNumber => 3;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final report = parseReport(puzzleInput);

    var gamma = '';
    var epsilon = '';

    for (var i = 0; i < report.first.length; i++) {
      final column = getColumnValues(report, i);
      final zeros = countValue(column, '0');
      final ones = countValue(column, '1');

      if (zeros > ones) {
        gamma += '1';
        epsilon += '0';
      } else {
        gamma += '0';
        epsilon += '1';
      }
    }

    var solution = int.parse(gamma, radix: 2) * int.parse(epsilon, radix: 2);

    return solution.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final report = parseReport(puzzleInput);

    var oxygen = findOxygenGeneratorRating(report.toList());
    var co2 = findCO2ScrubberRating(report.toList());

    var solution = int.parse(oxygen, radix: 2) * int.parse(co2, radix: 2);

    return solution.toString();
  }

  int countValue(Iterable<String> column, String value) {
    return column.where((element) => element == value).length;
  }

  Iterable<String> getColumnValues(List<String> report, int i) {
    return report.map((e) => e[i]);
  }

  List<String> parseReport(String puzzleInput) {
    final report = puzzleInput.split('\n').where((element) => element.isNotEmpty).toList();

    return report;
  }

  String findCO2ScrubberRating(List<String> report) {
    return findRating(report, 0, false);
  }

  String findOxygenGeneratorRating(List<String> report) {
    return findRating(report, 0, true);
  }

  String findRating(List<String> input, int coulmn, bool keepMostCommonValue) {
    final column = getColumnValues(input, coulmn);
    final zeros = countValue(column, '0');
    final ones = countValue(column, '1');

    if (zeros > ones) {
      input.removeWhere((element) => element[coulmn] == (keepMostCommonValue ? '1' : '0'));
    } else {
      input.removeWhere((element) => element[coulmn] == (keepMostCommonValue ? '0' : '1'));
    }

    if (input.length == 1) {
      return input.first;
    }

    return findRating(input, ++coulmn, keepMostCommonValue);
  }
}
