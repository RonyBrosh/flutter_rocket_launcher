import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/storage/shared_preferences/shared_preferences_wrapper.dart';
import 'package:flutter_rocket_launcher/core/presentation/router/router_service_locator.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_shared_preferences.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/data/use_case/set_is_welocme_message_enabled_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/presenter/welcome_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/presenter/welcome_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/router/welcome_router_impl.dart';

class WelcomeModule {
  static WelcomeScreenPresenter provideWelcomeScreenPresenter() {
    return WelcomeScreenPresenterImpl(
        WelcomeRouterImpl(RouterServiceLocator.getInstance().navigatorKey.currentState!),
        SetIsWelcomeMessageEnabledUseCaseImpl(
          SplashRepositoryImpl(SplashSharedPreferences(
            SharedPreferencesWrapper(),
            ErrorMapper(),
          )),
        ));
  }
}
