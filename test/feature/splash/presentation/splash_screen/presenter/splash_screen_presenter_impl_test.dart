import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/is_welcome_message_enabled_use_case.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/presenter/splash_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/router/splash_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SplashRouterMock extends Mock implements SplashRouter {}

class IsWelcomeMessageEnabledUseCaseMock extends Mock implements IsWelcomeMessageEnabledUseCase {}

void main() {
  final SplashRouterMock splashRouterMock = SplashRouterMock();
  final IsWelcomeMessageEnabledUseCaseMock isWelcomeMessageEnabledUseCaseMock = IsWelcomeMessageEnabledUseCaseMock();
  final SplashScreenPresenterImpl sut = SplashScreenPresenterImpl(splashRouterMock, isWelcomeMessageEnabledUseCaseMock);

  test('onGithubLinkClicked SHOULD goToGithub WHEN called', () {
    sut.onGithubLinkClicked();

    verify(splashRouterMock.goToGithub());
  });

  testWidgets('onScreenLoaded SHOULD emit SplashTitleAnimationState.ENTER WHEN called', (WidgetTester widgetTester) async {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;

    sut.onScreenLoaded();

    await widgetTester.pump(Duration(seconds: 2));
    expect(valueNotifier.value, SplashTitleAnimationState.ENTER);
  });

  testWidgets('onTitleEnterAnimationEnd SHOULD goToWelcomeMessage WHEN IsWelcomeMessageEnabledUseCase fails', (WidgetTester widgetTester) async {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.failure(ErrorType.unknown())));
    when(splashRouterMock.goToWelcomeMessage()).thenAnswer((realInvocation) => Future.value());

    sut.onTitleEnterAnimationEnd();

    await widgetTester.pump(Duration(seconds: 3));
    verify(splashRouterMock.goToWelcomeMessage());
    await widgetTester.pump(Duration(seconds: 1));
  });

  testWidgets('onTitleEnterAnimationEnd SHOULD emit SplashTitleAnimationState.EXIT WHEN IsWelcomeMessageEnabledUseCase return false', (WidgetTester widgetTester) async {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(false)));

    sut.onTitleEnterAnimationEnd();

    await widgetTester.pump(Duration(seconds: 3));
    expect(valueNotifier.value, SplashTitleAnimationState.EXIT);
  });

  testWidgets('onTitleEnterAnimationEnd SHOULD goToWelcomeMessage WHEN IsWelcomeMessageEnabledUseCase return true', (WidgetTester widgetTester) async {
    final ValueNotifier valueNotifier = sut.splashTitleAnimationState;
    valueNotifier.value = SplashTitleAnimationState.IDLE;
    when(isWelcomeMessageEnabledUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(true)));

    sut.onTitleEnterAnimationEnd();

    await widgetTester.pump(Duration(seconds: 3));
    verify(splashRouterMock.goToWelcomeMessage());
    await widgetTester.pump(Duration(seconds: 1));
  });
}
