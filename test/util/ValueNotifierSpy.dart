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
      expect(actualValues[index], expectedValues[index]);
    }
    _dispose();
  }

  void _dispose() {
    _valueNotifier.removeListener(_addCurrentValue);
  }

  void _addCurrentValue() {
    _values.add(_valueNotifier.value);
  }
}
