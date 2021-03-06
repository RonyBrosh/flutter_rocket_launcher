import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: Colors.blue[400],
    primaryColorDark: Colors.blue[700],
    accentColor: Colors.deepPurpleAccent[100],
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false, // 1
      systemOverlayStyle: SystemUiOverlayStyle.light, // 2
    ),
  );
}
