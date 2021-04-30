import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/is_welcome_message_enabled_use_case.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';

class SplashScreenPresenterImpl implements SplashScreenPresenter {
  final SplashRouter _splashRouter;
  final ValueNotifier<SplashTitleAnimationState> _splashTitleAnimationState = ValueNotifier(SplashTitleAnimationState.IDLE);
  final IsWelcomeMessageEnabledUseCase _isWelcomeMessageEnabledUseCase;

  SplashScreenPresenterImpl(this._splashRouter, this._isWelcomeMessageEnabledUseCase);

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
      _isWelcomeMessageEnabledUseCase().then((resultState) => {
            resultState.fold(success: (isWelcomeMessageEnabled) {
              if (isWelcomeMessageEnabled) {
                _splashRouter.goToWelcomeMessage();
              } else {
                splashTitleAnimationState.value = SplashTitleAnimationState.EXIT;
              }
            }, failure: (errorType) {
              _splashRouter.goToWelcomeMessage();
            })
          });
    });
  }
}
