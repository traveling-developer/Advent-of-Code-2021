import 'package:adventofcode2021/src/helper/columns_of_iterable_extension.dart';
import 'package:test/test.dart';

void main() {
  group('Columns of Iterable Extension', () {
    test('getColumns - 2x2 matrix - returns columns', () {
      final simpleMatrix = [
        [1, 2],
        [3, 4]
      ];

      var result = simpleMatrix.getColumns();

      expect(
          result,
          equals([
            [1, 3],
            [2, 4]
          ]));
    });

    test('getColumns - 2x4 matrix - returns columns', () {
      final simpleMatrix = [
        [1, 2, 3, 4],
        [5, 6, 7, 8]
      ];

      var result = simpleMatrix.getColumns();

      expect(
          result,
          equals([
            [1, 5],
            [2, 6],
            [3, 7],
            [4, 8]
          ]));
    });

    test('getColumns - 4x2 matrix - returns columns', () {
      final simpleMatrix = [
        [1, 2],
        [3, 4],
        [5, 6],
        [7, 8]
      ];

      var result = simpleMatrix.getColumns();

      expect(
          result,
          equals([
            [1, 3, 5, 7],
            [2, 4, 6, 8]
          ]));
    });
  });
}
