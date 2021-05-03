import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/di/splash_module.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/view/splash_screen.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/view/welcome_screen.dart';

class Routes {
  static const String SPLASH_SCREEN = "/";
  static const String WELCOME_SCREEN = "welcome_screen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen(SplashModule.provideSplashScreenPresenter()));
      case WELCOME_SCREEN:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
