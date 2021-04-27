import 'package:flutter_rocket_launcher/core/data/storage/shared_preferences/shared_preferences_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final String key = "key";
  final SharedPreferencesWrapper sut = SharedPreferencesWrapper();

  test('getBool SHOULD return false WHEN value not exist', () async {
    SharedPreferences.setMockInitialValues(Map());
    final bool expected = false;

    final bool result = await sut.getBool(key);

    expect(result, expected);
  });

  test('getBool SHOULD return true WHEN value not exist AND default value is true', () async {
    SharedPreferences.setMockInitialValues(Map());
    final bool expected = true;

    final bool result = await sut.getBool(key, defaultValue: true);

    expect(result, expected);
  });

  test('getBool SHOULD return true WHEN value exist AND true', () async {
    SharedPreferences.setMockInitialValues({key: true});
    final bool expected = true;

    final bool result = await sut.getBool(key);

    expect(result, expected);
  });

  test('setBool SHOULD return true WHEN set bool succeeds', () async {
    SharedPreferences.setMockInitialValues(Map());
    final bool expected = true;

    final bool result = await sut.setBool(key, false);

    expect(result, expected);
  });
}
