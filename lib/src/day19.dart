import 'dart:math';

import 'package:quiver/core.dart';

import 'day.dart';

class Day19 implements Day {
  @override
  int get dayNumber => 19;

  Map<Beacon, Scanner> positionedScanners = {};

  @override
  String solveFirstPuzzle(String puzzleInput) {
    final scanners = puzzleInput
        .split('\n\n')
        .where((element) => element.isNotEmpty)
        .map((e) => Scanner(e))
        .toList();

    positionedScanners[Beacon.fromCoordinates(0, 0, 0)] = scanners[0];
    scanners.removeAt(0);

    while (scanners.isNotEmpty) {
      findPositionedScanner(positionedScanners, scanners);
    }

    var allBeacons = positionedScanners.entries
        .map((e) => e.value.getBeaconsRelativeTo(e.key))
        .expand((element) => element)
        .toSet();

    return allBeacons.length.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    final scanners = puzzleInput
        .split('\n\n')
        .where((element) => element.isNotEmpty)
        .map((e) => Scanner(e))
        .toList();

    Map<Beacon, Scanner> fixedScanners = {};
    fixedScanners[Beacon.fromCoordinates(0, 0, 0)] = scanners[0];
    scanners.removeAt(0);

    while (scanners.isNotEmpty) {
      findPositionedScanner(fixedScanners, scanners);
    }

    List<int> allManhattenDistances = [];
    for (var first in fixedScanners.keys) {
      for (var second in fixedScanners.keys.where((element) => element != first)) {
        var manhattenDistance =
            (first.x - second.x).abs() + (first.y - second.y).abs() + (first.z - second.z).abs();
        allManhattenDistances.add(manhattenDistance);
      }
    }

    var maximalManhattenDistance = allManhattenDistances.reduce(max);

    return maximalManhattenDistance.toString();
  }

  void findPositionedScanner(Map<Beacon, Scanner> positionedScanners, List<Scanner> scanners) {
    for (var scannerToPosition in scanners) {
      for (var positionedScanner in positionedScanners.entries) {
        var positionedBeacon =
            positionedScanner.value.getBeaconsRelativeTo(positionedScanner.key).toSet();
        for (var positionedPoint in positionedBeacon) {
          var allRotations = getRotationsScanner(scannerToPosition);

          for (var rotation in allRotations) {
            for (var beacon in rotation.beacons) {
              var center = Beacon.fromCoordinates(positionedPoint.x - beacon.x,
                  positionedPoint.y - beacon.y, positionedPoint.z - beacon.z);

              var relativeBeacons = rotation.getBeaconsRelativeTo(center).toSet();

              var intersection = positionedBeacon.intersection(relativeBeacons);

              if (intersection.length >= 12) {
                scanners.remove(scannerToPosition);
                positionedScanners[center] = rotation;
                return;
              }
            }
          }
        }
      }
    }

    throw Exception();
  }

  Iterable<Scanner> getRotationsScanner(Scanner scanner) {
    List<Scanner> rotations = [];

    rotations.add(scanner);
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(-beacon.x, beacon.y, beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(beacon.x, -beacon.y, beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(beacon.x, beacon.y, -beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(-beacon.x, -beacon.y, beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(-beacon.x, beacon.y, -beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(beacon.x, -beacon.y, -beacon.z)));
    rotations.add(scanner.createNewScannerWithRotation(
        (Beacon beacon) => Beacon.fromCoordinates(-beacon.x, -beacon.y, -beacon.z)));

    var firstShift = createShiftedScanner(
        rotations, (Beacon beacon) => Beacon.fromCoordinates(beacon.y, beacon.z, beacon.x));
    var secondShift = createShiftedScanner(
        rotations, (Beacon beacon) => Beacon.fromCoordinates(beacon.z, beacon.x, beacon.y));
    var thirdShift = createShiftedScanner(
        rotations, (Beacon beacon) => Beacon.fromCoordinates(beacon.x, beacon.z, beacon.y));
    var fourthShift = createShiftedScanner(
        rotations, (Beacon beacon) => Beacon.fromCoordinates(beacon.y, beacon.x, beacon.z));
    var fifthShift = createShiftedScanner(
        rotations, (Beacon beacon) => Beacon.fromCoordinates(beacon.z, beacon.y, beacon.x));

    rotations.addAll(firstShift);
    rotations.addAll(secondShift);
    rotations.addAll(thirdShift);
    rotations.addAll(fourthShift);
    rotations.addAll(fifthShift);

    return rotations;
  }

  List<Scanner> createShiftedScanner(List<Scanner> scanners, Beacon Function(Beacon beacon) shift) {
    List<Scanner> shifts = [];

    for (var scanner in scanners) {
      shifts.add(scanner.createNewScannerWithRotation(shift));
    }

    return shifts;
  }
}

class Scanner {
  List<Beacon> beacons = [];
  late final int scannerId;

  Scanner(String rawScanner) {
    var splitted = rawScanner.split('\n').where((element) => element.isNotEmpty).toList();

    scannerId = int.parse(splitted.first.replaceAll('--- scanner ', '').replaceAll(' ---', ''));

    splitted.removeAt(0);
    for (var rawBeacon in splitted) {
      beacons.add(Beacon(rawBeacon));
    }
  }

  Scanner.from(this.beacons, this.scannerId);

  Iterable<Beacon> getBeaconsRelativeTo(Beacon beacon) {
    var relativeBeacons =
        beacons.map((e) => Beacon.fromCoordinates(e.x + beacon.x, e.y + beacon.y, e.z + beacon.z));

    return relativeBeacons;
  }

  Scanner createNewScannerWithRotation(Beacon Function(Beacon beacon) transform) {
    return Scanner.from(beacons.map((e) => transform(e)).toList(), scannerId);
  }
}

class Beacon {
  late int x;
  late int y;
  late int z;

  Beacon(String rawBeacon) {
    var coordinates = rawBeacon.split(',');

    x = int.parse(coordinates[0]);
    y = int.parse(coordinates[1]);
    z = int.parse(coordinates[2]);
  }

  Beacon.fromCoordinates(this.x, this.y, this.z);

  @override
  String toString() => '[$x, $y, $z]';

  @override
  bool operator ==(Object other) => other is Beacon && other.x == x && other.y == y && other.z == z;

  @override
  int get hashCode => hash3(x.hashCode, y.hashCode, z.hashCode);
}
