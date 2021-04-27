import 'package:collection/collection.dart';

extension ListExtentions on List {
  List orEmpty() {
    return this ?? [];
  }

  bool isEqual(List other) {
    if (other == null) return false;
    return ListEquality().equals(this, other);
  }

  int getHashCode() {
    int result = 0;
    forEach((element) {
      result ^= element.hashCode;
    });
    return result;
  }
}
