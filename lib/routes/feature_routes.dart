import 'package:flutter/widgets.dart';

abstract class FeatureRoutes {
  List<String> get screens;

  Route<dynamic> generateRoute(RouteSettings settings);
}
