import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/routes/feature_routes.dart';
import 'package:flutter_rocket_launcher/routes/features/rockets_routes.dart';
import 'package:flutter_rocket_launcher/routes/features/splash_routes.dart';

class RoutesGenerator {
  static RoutesGenerator _instance;

  List<FeatureRoutes> _featureRoutes = [
    SplashRoutes(),
    RocketsRoutes(),
  ];

  RoutesGenerator._();

  static RoutesGenerator getInstance() {
    if (_instance == null) {
      _instance = RoutesGenerator._();
    }

    return _instance;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    for (FeatureRoutes nextFeatureRoutes in _featureRoutes) {
      if (nextFeatureRoutes.screens.contains(settings.name)) {
        return nextFeatureRoutes.generateRoute(settings);
      }
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}
