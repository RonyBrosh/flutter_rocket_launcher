import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/style/text_style.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/view/splash_screen.dart';
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
      ),
      home: SplashScreen(),
    );
  }
}
