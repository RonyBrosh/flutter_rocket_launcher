import 'package:flutter_rocket_launcher/core/util/extension/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('orEmpty SHOULD return empty string WHEN input is null', () {
    final String? input = null;
    final String expected = "";

    final String result = input.orEmpty();

    expect(result, expected);
  });

  test('orEmpty SHOULD return input WHEN input is not null', () {
    final String input = "input";
    final String expected = "input";

    final String result = input.orEmpty();

    expect(result, expected);
  });
}
