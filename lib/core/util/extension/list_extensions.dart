import 'package:collection/collection.dart';

extension ListExtentions on List? {
  List orEmpty() {
    return this ?? [];
  }

  bool isEqual(List other) {
    return ListEquality().equals(this, other);
  }

  int getHashCode() {
    int result = 0;

    List? list = this;
    if (list != null) {
      list.forEach((element) {
        result ^= element.hashCode;
      });
    }

    return result;
  }
}
