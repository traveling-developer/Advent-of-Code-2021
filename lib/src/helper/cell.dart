import 'package:quiver/core.dart';

class Cell<T> {
  final int x;
  final int y;
  late T value;

  Cell(this.x, this.y, this.value);

  @override
  bool operator ==(Object other) =>
      other is Cell<T> && other.x == x && other.y == y && other.value == value;

  @override
  int get hashCode => hash3(x.hashCode, y.hashCode, value.hashCode);
}
