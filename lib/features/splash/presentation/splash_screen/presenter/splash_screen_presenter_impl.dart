import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router_impl.dart';

class SplashScreenPresenterImpl implements SplashScreenPresenter {
  final SplashRouter _splashRouter = SplashRouterImpl();
  final ValueNotifier<SplashTitleAnimationState> _splashTitleAnimationState = ValueNotifier(SplashTitleAnimationState.IDLE);

  @override
  ValueNotifier<SplashTitleAnimationState> get splashTitleAnimationState => _splashTitleAnimationState;

  @override
  void onGithubLinkClicked() async {
    _splashRouter.goToGithub();
  }

  @override
  void onScreenLoaded() {
    Future.delayed(Duration(seconds: 2), () {
      splashTitleAnimationState.value = SplashTitleAnimationState.ENTER;
    });
  }

  @override
  void onTitleEnterAnimationEnd() {
    Future.delayed(Duration(seconds: 3), () {
      splashTitleAnimationState.value = SplashTitleAnimationState.EXIT;
    });
  }
}
