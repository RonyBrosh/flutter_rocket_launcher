import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/is_welcome_message_enabled_use_case.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SplashRouterMock extends Mock implements SplashRouter {}

class IsWelcomeMessageEnabledUseCaseMock extends Mock implements IsWelcomeMessageEnabledUseCase {}

void main() {
  final SplashRouterMock splashRouterMock = SplashRouterMock();
  final IsWelcomeMessageEnabledUseCaseMock isWelcomeMessageEnabledUseCaseMock = IsWelcomeMessageEnabledUseCaseMock();
  final SplashScreenPresenterImpl sut = SplashScreenPresenterImpl(splashRouterMock, isWelcomeMessageEnabledUseCaseMock);

  test('onGithubLinkClicked SHOULD goToGithub WHEN called', () {
    sut.onGithubLinkClicked();

    verify(() => splashRouterMock.goToGithub());
  });

  test('onScreenLoaded SHOULD emit SplashTitleAnimationState.ENTER WHEN called', () {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;

    fakeAsync((async) {
      sut.onScreenLoaded();

      async.flushTimers();
      expect(valueNotifier.value, SplashTitleAnimationState.ENTER);
    });
  });

  test('onTitleEnterAnimationEnd SHOULD goToWelcomeMessage WHEN IsWelcomeMessageEnabledUseCase fails', () {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(() => isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.failure(ErrorType.unknown())));
    when(() => splashRouterMock.goToWelcomeMessage()).thenAnswer((realInvocation) => Future.value());

    fakeAsync((async) {
      sut.onTitleEnterAnimationEnd();

      async.flushTimers();
      verify(() => splashRouterMock.goToWelcomeMessage());
    });
  });

  test('onTitleEnterAnimationEnd SHOULD emit SplashTitleAnimationState.EXIT WHEN IsWelcomeMessageEnabledUseCase return false', () {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(() => isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(false)));

    fakeAsync((async) {
      sut.onTitleEnterAnimationEnd();

      async.flushTimers();
      expect(valueNotifier.value, SplashTitleAnimationState.EXIT);
    });
  });

  test('onTitleEnterAnimationEnd SHOULD goToWelcomeMessage WHEN IsWelcomeMessageEnabledUseCase return true', () {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(() => isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(true)));

    fakeAsync((async) {
      sut.onTitleEnterAnimationEnd();

      async.flushTimers();
      verify(() => splashRouterMock.goToWelcomeMessage());
    });
  });
}
