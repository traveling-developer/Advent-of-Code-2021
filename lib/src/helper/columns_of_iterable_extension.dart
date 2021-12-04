extension ColumnsOfIterable<T> on Iterable<Iterable<T>> {
  List<List<T>> getColumns() {
    List<List<T>> columns = [];

    for (var i = 0; i < first.length; i++) {
      List<T> column = [];

      for (var j = 0; j < length; j++) {
        column.add(elementAt(j).elementAt(i));
      }

      columns.add(column);
    }

    return columns;
  }
}
