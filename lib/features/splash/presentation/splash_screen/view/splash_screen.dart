import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_link.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/widgets/splash_title_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenPresenter _splashScreenPresenter = SplashScreenPresenterImpl();

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _splashScreenPresenter.onScreenLoaded();

    rootBundle.load('lib/features/splash/presentation/assets/graphics/rocket_launcher.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('idle'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: _riveArtboard == null
                    ? Center(
                        child: SvgPicture.asset(SplashAssets.SPLASH_ROCKET),
                      )
                    : Rive(
                        fit: BoxFit.none,
                        artboard: _riveArtboard,
                      ),
              ),
              // SvgPicture.asset(SplashAssets.SPLASH_ROCKET),
              Expanded(
                child: SplashTitleWidget(_splashScreenPresenter.splashTitleAnimationState, () {
                  _splashScreenPresenter.onTitleEnterAnimationEnd();
                }),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextLink(SplashResources.from(context).strings.splashRepositoryLinkText, () {
              _splashScreenPresenter.onGithubLinkClicked();
            }),
          )
        ],
      ),
    );
  }
}
