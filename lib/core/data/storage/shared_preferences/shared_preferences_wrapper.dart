import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }
}
