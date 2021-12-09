import 'cell.dart';

class Table<T> {
  Iterable<Iterable<T>> rows;

  Table(this.rows) {
    if (rows.isEmpty) {
      throw ArgumentError.value(rows);
    }
  }

  int get rowLength => rows.length;

  int get columnsLength => rows.first.length;

  List<List<T>> getColumns() {
    List<List<T>> columns = [];

    for (var i = 0; i < columnsLength; i++) {
      List<T> column = [];

      for (var j = 0; j < rowLength; j++) {
        column.add(rows.elementAt(j).elementAt(i));
      }

      columns.add(column);
    }

    return columns;
  }

  T getValue(int rowIndex, int columnIndex) {
    if (_isValidRowIndex(rowIndex)) {
      if (_isValidColumnIndex(columnIndex)) {
        return rows.elementAt(rowIndex).elementAt(columnIndex);
      }
      throw ArgumentError.value(columnIndex);
    }
    throw ArgumentError.value(rowIndex);
  }

  List<Cell<T>> getNeighboursByCell(Cell<T> cell) {
    return getNeighbours(cell.y, cell.x);
  }

  List<Cell<T>> getNeighbours(int rowIndex, int columnIndex) {
    List<Cell<T>> neighbourCells = [];

    _addIfExists(rowIndex - 1, columnIndex, neighbourCells);
    _addIfExists(rowIndex + 1, columnIndex, neighbourCells);
    _addIfExists(rowIndex, columnIndex - 1, neighbourCells);
    _addIfExists(rowIndex, columnIndex + 1, neighbourCells);

    return neighbourCells;
  }

  Iterable<Cell<T>> asIterableCells() sync* {
    for (var i = 0; i < rowLength; i++) {
      for (var j = 0; j < columnsLength; j++) {
        yield Cell(j, i, rows.elementAt(i).elementAt(j));
      }
    }
  }

  bool _isValidRowIndex(int index) {
    return index >= 0 && index < rowLength;
  }

  bool _isValidColumnIndex(int index) {
    return index >= 0 && index < columnsLength;
  }

  void _addIfExists(int rowIndex, int columnIndex, List<Cell<T>> list) {
    if (_isValidRowIndex(rowIndex) && _isValidColumnIndex(columnIndex)) {
      list.add(Cell(columnIndex, rowIndex, rows.elementAt(rowIndex).elementAt(columnIndex)));
    }
  }
}
