import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/router/router_service_locator.dart';
import 'package:flutter_rocket_launcher/core/presentation/style/text_style.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, SplashAssets.SPLASH_ROCKET), null);

  runApp(RocketLauncherApp());
}

class RocketLauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(
            caption: STYLE_CAPTION,
          ),
          primaryColor: Colors.blue[400],
          primaryColorDark: Colors.blue[700],
          accentColor: Colors.deepPurpleAccent[100],
          backgroundColor: Colors.white),
      navigatorKey: RouterServiceLocator.getInstance().navigatorKey,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
