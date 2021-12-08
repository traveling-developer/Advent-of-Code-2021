import 'package:collection/collection.dart';

extension SetEquals on Set<dynamic> {
  bool equals(Set<dynamic> right) {
    var setEquality = const SetEquality<dynamic>();

    return setEquality.equals(this, right);
  }
}
