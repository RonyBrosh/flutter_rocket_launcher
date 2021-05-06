import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/strings/strings.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:flutter_rocket_launcher/routes/features/splash_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashRouterImpl implements SplashRouter {
  final NavigatorState _navigatorState;

  SplashRouterImpl(this._navigatorState);

  @override
  void goToGithub() async {
    const url = SplashStrings.GITHUB_URL;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  void goToRocketList() {
    // TODO: implement goToRocketList
  }

  @override
  void goToWelcomeMessage() {
    _navigatorState.pushNamed(SplashRoutes.WELCOME_SCREEN);
  }
}
