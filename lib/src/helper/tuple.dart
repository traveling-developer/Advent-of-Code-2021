import 'package:quiver/core.dart';

class Tuple<T1, T2> {
  T1 firstItem;

  T2 secondItem;

  Tuple(this.firstItem, this.secondItem);

  @override
  String toString() => '[$firstItem, $secondItem]';

  @override
  bool operator ==(Object other) =>
      other is Tuple && other.firstItem == firstItem && other.secondItem == secondItem;

  @override
  int get hashCode => hash2(firstItem.hashCode, secondItem.hashCode);
}
