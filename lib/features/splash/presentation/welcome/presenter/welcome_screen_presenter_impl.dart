import 'package:flutter_rocket_launcher/features/splash/domain/use_case/set_is_welocme_message_enabled_use_case.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/presenter/welcome_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/router/welcome_router.dart';

class WelcomeScreenPresenterImpl implements WelcomeScreenPresenter {
  final WelcomeRouter _welcomeRouter;
  final SetIsWelcomeMessageEnabledUseCase _setIsWelcomeMessageEnabledUseCase;

  WelcomeScreenPresenterImpl(this._welcomeRouter, this._setIsWelcomeMessageEnabledUseCase);

  @override
  void onGithubLinkClicked() {
    _welcomeRouter.goToGithub();
  }

  @override
  void onNextClicked() {
    _welcomeRouter.goBack();
  }

  @override
  void setIsWelcomeMessageEnabled(bool isEnabled) async {
    await _setIsWelcomeMessageEnabledUseCase(isEnabled);
  }
}
