import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class ValueNotifierSpy {
  final Queue<dynamic> _values = Queue();
  final ValueNotifier _valueNotifier;

  ValueNotifierSpy(this._valueNotifier) {
    _valueNotifier.addListener(_addCurrentValue);
    _values.add(_valueNotifier.value);
  }

  void log() {
    _values.forEach((element) {
      print("$element\n");
    });
  }

  void assertOrdered(List<dynamic> expectedValues) {
    final List<dynamic> actualValues = _values.toList();
    expect(actualValues.length, expectedValues.length);
    for (int index = 0; index < _values.length; index++) {
      expect(
        actualValues[index],
        expectedValues[index],
        reason: "Assert Ordered failed for index $index:\nactualValues[index] = ${actualValues[index]}\nexpectedValues[index] = ${expectedValues[index]}",
      );
    }
    _dispose();
  }

  void assertAtIndex(int index, dynamic expected) {
    expect(
      _values.elementAt(index),
      expected,
      reason: "Assert at index failed for index $index:\nactualValues = ${_values.elementAt(index)}\nexpectedValues = $expected",
    );
  }

  void _dispose() {
    _valueNotifier.removeListener(_addCurrentValue);
  }

  void _addCurrentValue() {
    _values.add(_valueNotifier.value);
  }
}
