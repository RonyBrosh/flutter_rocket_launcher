import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class SplashRocketAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashRocketAnimationState();
  }
}

class _SplashRocketAnimationState extends State<SplashRocketAnimation> {
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    rootBundle.load(SplashAssets.SPLASH_ROCKET_ANIMATION).then(
      (data) async {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        artBoard.addController(SimpleAnimation('idle'));
        setState(() => _artboard = artBoard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Artboard? artboard = _artboard;
    return artboard == null
        ? Center(
            child: SvgPicture.asset(SplashAssets.SPLASH_ROCKET),
          )
        : Rive(
            fit: BoxFit.none,
            artboard: artboard,
          );
  }
}
