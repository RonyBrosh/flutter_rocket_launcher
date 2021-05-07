import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/transitions/transition_vertical_slide.dart';
import 'package:flutter_rocket_launcher/features/splash/di/splash_module.dart';
import 'package:flutter_rocket_launcher/features/splash/di/welcome_module.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/view/splash_screen.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/view/welcome_screen.dart';
import 'package:flutter_rocket_launcher/routes/feature_routes.dart';

class SplashRoutes extends FeatureRoutes {
  static const String SPLASH_SCREEN = "/";
  static const String WELCOME_SCREEN = "welcome_screen";
  static const String ROCKETS_SCREEN = "rockets_screen";

  @override
  List<String> get screens => [
        SPLASH_SCREEN,
        WELCOME_SCREEN,
      ];

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen(SplashModule.provideSplashScreenPresenter()));
      case WELCOME_SCREEN:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(WelcomeModule.provideWelcomeScreenPresenter()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => ScreenTransition.verticalSlideTransition(animation, child));

      default:
        throw Exception("Can't generate route for ${settings.name}");
    }
  }
}
