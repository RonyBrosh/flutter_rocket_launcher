import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:flutter_rocket_launcher/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashRouterImpl implements SplashRouter {
  final NavigatorState _navigatorState;

  SplashRouterImpl(this._navigatorState);

  @override
  void goToGithub() async {
    const url = "https://github.com/RonyBrosh/FlutterRocketLauncher";
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
    _navigatorState.pushNamed(Routes.WELCOME_SCREEN);
  }
}
