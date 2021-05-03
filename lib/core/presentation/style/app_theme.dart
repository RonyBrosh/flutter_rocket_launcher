import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/style/text_style.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      caption: STYLE_CAPTION,
    ),
    primaryColor: Colors.blue[400],
    primaryColorDark: Colors.blue[700],
    accentColor: Colors.deepPurpleAccent[100],
    backgroundColor: Colors.white,
  );
}
