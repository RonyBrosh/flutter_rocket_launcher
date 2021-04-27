import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getBool(key) ?? defaultValue;
    return Future.value(result);
  }

  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.setBool(key, value);
    return Future.value(result);
  }
}
