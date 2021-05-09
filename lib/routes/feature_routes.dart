import 'package:flutter/widgets.dart';

abstract class FeatureRoutes {
  List<String> get screens;

  Route<dynamic> generateRoute(RouteSettings settings);

  Route<dynamic> generateDefaultRoute(RouteSettings settings) {
    throw Exception("Can't generate route for ${settings.name}");
  }
}
