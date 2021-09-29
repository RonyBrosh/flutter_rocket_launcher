import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_link.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/widgets/splash_rocket_animation.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/widgets/splash_title_widget.dart';

class SplashScreen extends StatefulWidget {
  final SplashScreenPresenter _splashScreenPresenter;

  SplashScreen(this._splashScreenPresenter) {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget._splashScreenPresenter.onScreenLoaded();
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
              Expanded(child: SplashRocketAnimation()),
              Expanded(
                child: SplashTitleWidget(
                  splashTitleAnimationState: widget._splashScreenPresenter.splashTitleAnimationState,
                  onTitleEnterAnimationEnd: widget._splashScreenPresenter.onTitleEnterAnimationEnd,
                  onTitleExitAnimationEnd: widget._splashScreenPresenter.onTitleExitAnimationEnd,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextLink(SplashResources.from(context).strings.githubLinkText, () {
              widget._splashScreenPresenter.onGithubLinkClicked();
            }),
          )
        ],
      ),
    );
  }
}
