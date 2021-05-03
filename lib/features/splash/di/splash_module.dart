import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/storage/shared_preferences/shared_preferences_wrapper.dart';
import 'package:flutter_rocket_launcher/core/presentation/router/router_service_locator.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_shared_preferences.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/data/use_case/is_welcome_message_enabled_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router_impl.dart';

class SplashModule {
  static SplashScreenPresenter provideSplashScreenPresenter() {
    return SplashScreenPresenterImpl(
        SplashRouterImpl(RouterServiceLocator.getInstance().navigatorKey.currentState),
        IsWelcomeMessageEnabledUseCaseImpl(
          SplashRepositoryImpl(SplashSharedPreferences(
            SharedPreferencesWrapper(),
            ErrorMapper(),
          )),
        ));
  }
}
