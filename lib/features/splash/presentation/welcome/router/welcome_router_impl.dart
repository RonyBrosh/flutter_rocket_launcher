import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/strings/strings.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/router/welcome_router.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeRouterImpl implements WelcomeRouter {
  final NavigatorState _navigatorState;

  WelcomeRouterImpl(this._navigatorState);

  @override
  void goToGithub() async {
    const url = SplashStrings.GITHUB_URL;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  void goBack() {
    _navigatorState.pop();
  }
}
