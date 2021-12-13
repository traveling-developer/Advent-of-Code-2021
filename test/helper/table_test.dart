import 'package:adventofcode2021/src/helper/cell.dart';
import 'package:adventofcode2021/src/helper/table.dart';
import 'package:test/test.dart';

void main() {
  group('Table', () {
    test('constructor - empty list - throws argument error', () {
      expect(() => Table([]), throwsArgumentError);
    });

    test('rowLength - some row - returns length of row', () {
      final rowLength = 10;
      final table = Table(Iterable<Iterable<int>>.generate(10, (i) => []));

      var result = table.rowLength;

      expect(result, equals(rowLength));
    });

    test('columnsLength - some column - returns length of column', () {
      final columnLength = 10;
      final table =
          Table(Iterable<Iterable<int>>.generate(1, (i) => Iterable.generate(columnLength)));

      var result = table.columnsLength;

      expect(result, equals(columnLength));
    });

    test('getColumns - 2x2 matrix - returns columns', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      var result = table.getColumns();

      expect(
          result,
          equals([
            [1, 3],
            [2, 4]
          ]));
    });

    test('getColumns - 2x4 matrix - returns columns', () {
      final table = Table([
        [1, 2, 3, 4],
        [5, 6, 7, 8]
      ]);

      var result = table.getColumns();

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
      final table = Table([
        [1, 2],
        [3, 4],
        [5, 6],
        [7, 8]
      ]);

      var result = table.getColumns();

      expect(
          result,
          equals([
            [1, 3, 5, 7],
            [2, 4, 6, 8]
          ]));
    });

    test('getValue - valid indicies - returns value', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      var result = table.getValue(1, 1);

      expect(result, equals(4));
    });

    test('getValue - invalid row index - throws argument error', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      expect(() => table.getValue(2, 0), throwsArgumentError);
    });

    test('getValue - invalid column index - throws argument error', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      expect(() => table.getValue(0, 2), throwsArgumentError);
    });

    test('getNeighbours - simple table - returns neighbours', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      var iterable = table.getNeighbours(1, 0);

      expect(iterable, equals([Cell(1, 1, 4), Cell(0, 0, 1)]));
    });

    test('asIterableCells - simple table - returns cells', () {
      final table = Table([
        [1, 2],
        [3, 4]
      ]);

      var iterable = table.asIterableCells().toList();

      expect(iterable, equals([Cell(0, 0, 1), Cell(1, 0, 2), Cell(0, 1, 3), Cell(1, 1, 4)]));
    });

    test('splitHorizontal - simple table - returns splitted tables', () {
      final table = Table([
        [1, 2],
        [3, 4],
        [5, 6]
      ]);

      var iterable = table.splitHorizontal(1);

      expect(iterable.first.asIterableCells(), equals([Cell(0, 0, 1), Cell(1, 0, 2)]));
      expect(iterable.last.asIterableCells(), equals([Cell(0, 0, 5), Cell(1, 0, 6)]));
    });

    test('splitVertical - simple table - returns splitted tables', () {
      final table = Table([
        [1, 2, 3],
        [4, 5, 6]
      ]);

      var iterable = table.splitVertical(1);

      expect(iterable.first.asIterableCells(), equals([Cell(0, 0, 1), Cell(0, 1, 4)]));
      expect(iterable.last.asIterableCells(), equals([Cell(0, 0, 3), Cell(0, 1, 6)]));
    });
  });
}
