import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';

abstract class SplashScreenPresenter {
  SplashScreenPresenter._();

  ValueNotifier<SplashTitleAnimationState> get splashTitleAnimationState;

  void onScreenLoaded();

  void onTitleEnterAnimationEnd();

  void onTitleExitAnimationEnd();

  void onGithubLinkClicked();
}
