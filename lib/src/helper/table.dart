import 'cell.dart';

class Table<T> {
  final Iterable<Iterable<T>> _rows;
  List<List<Cell<T>>> cells = [];

  Table(this._rows) {
    if (_rows.isEmpty) {
      throw ArgumentError.value(_rows);
    }

    _initializeCells();
  }

  @override
  String toString() {
    var stringBuffer = StringBuffer();

    for (var row in cells) {
      var rowValues = row.map((e) => e.value).toList();
      stringBuffer.write('\n');
      stringBuffer.write(rowValues.toString());
    }

    return stringBuffer.toString();
  }

  int get rowLength => _rows.length;

  int get columnsLength => _rows.first.length;

  List<List<T>> getColumns() {
    List<List<T>> columns = [];

    for (var i = 0; i < columnsLength; i++) {
      List<T> column = [];

      for (var j = 0; j < rowLength; j++) {
        column.add(_rows.elementAt(j).elementAt(i));
      }

      columns.add(column);
    }

    return columns;
  }

  List<List<Cell<T>>> getCellsColumns() {
    List<List<Cell<T>>> columns = [];

    for (var i = 0; i < columnsLength; i++) {
      List<Cell<T>> column = [];

      for (var j = 0; j < rowLength; j++) {
        column.add(cells.elementAt(j).elementAt(i));
      }

      columns.add(column);
    }

    return columns;
  }

  void setValue(int rowIndex, int columnIndex, T value) {
    if (_isValidRowIndex(rowIndex)) {
      if (_isValidColumnIndex(columnIndex)) {
        cells.elementAt(rowIndex).elementAt(columnIndex).value = value;
        return;
      }
      throw ArgumentError.value(columnIndex);
    }
    throw ArgumentError.value(rowIndex);
  }

  T getValue(int rowIndex, int columnIndex) {
    if (_isValidRowIndex(rowIndex)) {
      if (_isValidColumnIndex(columnIndex)) {
        return cells.elementAt(rowIndex).elementAt(columnIndex).value;
      }
      throw ArgumentError.value(columnIndex);
    }
    throw ArgumentError.value(rowIndex);
  }

  List<Cell<T>> getNeighboursByCell(Cell<T> cell) {
    return getNeighbours(cell.y, cell.x);
  }

  List<Cell<T>> getVerticalNeighbours(int rowIndex, int columnIndex) {
    List<Cell<T>> neighbourCells = [];

    _addToListIfExists(rowIndex, columnIndex - 1, neighbourCells);
    _addToListIfExists(rowIndex, columnIndex + 1, neighbourCells);

    return neighbourCells;
  }

  List<Cell<T>> getHorizontalNeighbours(int rowIndex, int columnIndex) {
    List<Cell<T>> neighbourCells = [];

    _addToListIfExists(rowIndex - 1, columnIndex, neighbourCells);
    _addToListIfExists(rowIndex + 1, columnIndex, neighbourCells);

    return neighbourCells;
  }

  List<Cell<T>> getNeighbours(int rowIndex, int columnIndex) {
    List<Cell<T>> neighbourCells = getVerticalNeighbours(rowIndex, columnIndex);

    neighbourCells.addAll(getHorizontalNeighbours(rowIndex, columnIndex));

    return neighbourCells;
  }

  List<Cell<T>> getAllNeighbours(int rowIndex, int columnIndex) {
    List<Cell<T>> neighbourCells = getNeighbours(rowIndex, columnIndex);

    _addToListIfExists(rowIndex - 1, columnIndex - 1, neighbourCells);
    _addToListIfExists(rowIndex - 1, columnIndex + 1, neighbourCells);
    _addToListIfExists(rowIndex + 1, columnIndex - 1, neighbourCells);
    _addToListIfExists(rowIndex + 1, columnIndex + 1, neighbourCells);

    return neighbourCells;
  }

  Iterable<Cell<T>> asIterableCells() sync* {
    for (var i = 0; i < rowLength; i++) {
      for (var j = 0; j < columnsLength; j++) {
        yield cells.elementAt(i).elementAt(j);
      }
    }
  }

  List<Table<T>> splitVertical(int splitIndex) {
    var columns = getCellsColumns();

    var leftPart = columns.sublist(0, splitIndex);
    var rightPart = columns.sublist(splitIndex + 1, columns.length);

    var leftTable = Table(_columnsToRows(leftPart));
    var rightTable = Table(_columnsToRows(rightPart));

    return [leftTable, rightTable];
  }

  List<Table<T>> splitHorizontal(int splitIndex) {
    var upperPart = cells.sublist(0, splitIndex);
    var lowerPart = cells.sublist(splitIndex + 1, cells.length);

    var upperTable = Table(upperPart.map((e) => e.map((e) => e.value)));
    var lowerTable = Table(lowerPart.map((e) => e.map((e) => e.value)));

    return [upperTable, lowerTable];
  }

  void _initializeCells() {
    for (var i = 0; i < rowLength; i++) {
      List<Cell<T>> row = [];
      for (var j = 0; j < columnsLength; j++) {
        row.add(Cell(j, i, _rows.elementAt(i).elementAt(j)));
      }
      cells.add(row);
    }
  }

  bool _isValidRowIndex(int index) {
    return index >= 0 && index < rowLength;
  }

  bool _isValidColumnIndex(int index) {
    return index >= 0 && index < columnsLength;
  }

  void _addToListIfExists(int rowIndex, int columnIndex, List<Cell<T>> list) {
    if (_isValidRowIndex(rowIndex) && _isValidColumnIndex(columnIndex)) {
      list.add(cells.elementAt(rowIndex).elementAt(columnIndex));
    }
  }

  List<List<T>> _columnsToRows(List<List<Cell<T>>> part) {
    List<List<T>> rows = List.generate(part.first.length, (index) => []);
    for (var i = 0; i < part.length; i++) {
      for (var j = 0; j < part.first.length; j++) {
        rows[j].add(part.elementAt(i).elementAt(j).value);
      }
    }

    return rows;
  }
}
