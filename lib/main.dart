import 'dart:io';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rocket_launcher/core/presentation/router/router_service_locator.dart';
import 'package:flutter_rocket_launcher/core/presentation/style/app_theme.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/routes/routes_generator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, SplashAssets.SPLASH_ROCKET), null);

  if (Foundation.kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  runApp(RocketLauncherApp());
}

class RocketLauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      navigatorKey: RouterServiceLocator.getInstance().navigatorKey,
      onGenerateRoute: RoutesGenerator.getInstance().generateRoute,
    );
  }
}
