import 'package:flutter_rocket_launcher/core/util/extension/boolean_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('orEmpty SHOULD return false WHEN input is null', () {
    final bool? input = null;
    final bool expected = false;

    final bool result = input.orFalse();

    expect(result, expected);
  });

  test('orEmpty SHOULD return input WHEN input is not null', () {
    final bool input = true;
    final bool expected = true;

    final bool result = input.orFalse();

    expect(result, expected);
  });
}
