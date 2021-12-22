import 'dart:math';

import 'day.dart';

class Day20 implements Day {
  @override
  int get dayNumber => 20;

  @override
  String solveFirstPuzzle(String puzzleInput) {
    var parsed = puzzleInput.split('\n\n').where((element) => element.isNotEmpty);
    var imageEnhancementAlgorthim = parsed.first;

    var inputImage = Image(parsed.last
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .toList());

    for (var i = 0; i < 2; i++) {
      var newImage = Image([[]]);
      var minX = inputImage.pixels.keys.map((e) => e.x).reduce(min);
      var maxX = inputImage.pixels.keys.map((e) => e.x).reduce(max);
      var minY = inputImage.pixels.keys.map((e) => e.y).reduce(min);
      var maxY = inputImage.pixels.keys.map((e) => e.y).reduce(max);

      for (var i = minX - 2; i <= maxX + 2; i++) {
        for (var j = minY - 2; j <= maxY + 2; j++) {
          var currentPoint = Point(i, j);
          var index = inputImage.getNeighbours(currentPoint);
          var newValue = imageEnhancementAlgorthim[index];

          newImage.pixels[currentPoint] = newValue;
        }
      }

      inputImage = newImage;
      inputImage.outsidePixelValue = inputImage.outsidePixelValue == '#'
          ? imageEnhancementAlgorthim[511]
          : imageEnhancementAlgorthim[0];
    }

    var numberOf = inputImage.pixels.values.where((element) => element == '#').length;

    return numberOf.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    var parsed = puzzleInput.split('\n\n').where((element) => element.isNotEmpty);
    var imageEnhancementAlgorthim = parsed.first;

    var inputImage = Image(parsed.last
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((e) => e.split(''))
        .toList());

    for (var i = 0; i < 50; i++) {
      var newImage = Image([[]]);
      var minX = inputImage.pixels.keys.map((e) => e.x).reduce(min);
      var maxX = inputImage.pixels.keys.map((e) => e.x).reduce(max);
      var minY = inputImage.pixels.keys.map((e) => e.y).reduce(min);
      var maxY = inputImage.pixels.keys.map((e) => e.y).reduce(max);

      for (var i = minX - 1; i <= maxX + 1; i++) {
        for (var j = minY - 1; j <= maxY + 1; j++) {
          var currentPoint = Point(i, j);
          var index = inputImage.getNeighbours(currentPoint);
          var newValue = imageEnhancementAlgorthim[index];

          newImage.pixels[currentPoint] = newValue;
        }
      }

      newImage.outsidePixelValue = inputImage.outsidePixelValue == '#'
          ? imageEnhancementAlgorthim[511]
          : imageEnhancementAlgorthim[0];
      inputImage = newImage;
    }

    var numberOf = inputImage.pixels.values.where((element) => element == '#').length;

    return numberOf.toString();
  }
}

class Image {
  Map<Point, String> pixels = {};
  String outsidePixelValue = '.';

  Image(List<List<String>> rawPixels) {
    for (var i = 0; i < rawPixels.length; i++) {
      for (var j = 0; j < rawPixels.first.length; j++) {
        pixels[Point(j, i)] = rawPixels[i][j];
      }
    }
  }

  int getNeighbours(Point point) {
    var firstPart = getValue(Point(point.x - 1, point.y - 1)) +
        getValue(Point(point.x, point.y - 1)) +
        getValue(Point(point.x + 1, point.y - 1));
    var secondPart = getValue(Point(point.x - 1, point.y)) +
        getValue(Point(point.x, point.y)) +
        getValue(Point(point.x + 1, point.y));
    var thirdPart = getValue(Point(point.x - 1, point.y + 1)) +
        getValue(Point(point.x, point.y + 1)) +
        getValue(Point(point.x + 1, point.y + 1));

    var binary = (firstPart + secondPart + thirdPart).replaceAll('.', '0').replaceAll('#', '1');
    var value = int.parse(binary, radix: 2);

    return value;
  }

  String getValue(Point point) {
    if (pixels.containsKey(point)) {
      return pixels[point]!;
    }

    return outsidePixelValue;
  }
}
