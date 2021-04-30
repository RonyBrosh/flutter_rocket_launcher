import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashRouterImpl implements SplashRouter {
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
    // TODO: implement goToWelcomeMessage
  }
}
