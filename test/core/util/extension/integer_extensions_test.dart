import 'package:flutter_rocket_launcher/core/util/extension/integer_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('orZero SHOULD return 0 WHEN input is null', () {
    final int? input = null;
    final int expected = 0;

    final int result = input.orZero();

    expect(result, expected);
  });

  test('orZero SHOULD return input WHEN input is not null', () {
    final int input = 100;
    final int expected = 100;

    final int result = input.orZero();

    expect(result, expected);
  });

  test('isInRange SHOULD return true WHEN input is in range', () {
    final int input = 1;

    final bool result = input.isInRange(start: 1, end: 10);

    expect(result, true);
  });

  test('isInRange SHOULD return false WHEN input is not in range', () {
    final int input = 0;

    final bool result = input.isInRange(start: 1, end: 10);

    expect(result, false);
  });
}
