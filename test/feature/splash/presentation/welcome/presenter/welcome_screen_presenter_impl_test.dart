import 'package:flutter_rocket_launcher/features/splash/domain/use_case/set_is_welocme_message_enabled_use_case.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/presenter/welcome_screen_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/router/welcome_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class WelcomeRouterMock extends Mock implements WelcomeRouter {}

class SetIsWelcomeMessageEnabledUseCaseMock extends Mock implements SetIsWelcomeMessageEnabledUseCase {}

void main() {
  final WelcomeRouterMock welcomeRouterMock = WelcomeRouterMock();
  final SetIsWelcomeMessageEnabledUseCaseMock setIsWelcomeMessageEnabledUseCaseMock = SetIsWelcomeMessageEnabledUseCaseMock();
  final WelcomeScreenPresenterImpl sut = WelcomeScreenPresenterImpl(welcomeRouterMock, setIsWelcomeMessageEnabledUseCaseMock);

  test('onGithubLinkClicked SHOULD goToGithub WHEN called', () {
    sut.onGithubLinkClicked();

    verify(welcomeRouterMock.goToGithub());
  });

  test('onNextClicked SHOULD goBack WHEN called', () {
    sut.onNextClicked();

    verify(welcomeRouterMock.goBack());
  });

  test('setIsWelcomeMessageEnabled SHOULD invoke use case WHEN called', () {
    sut.setIsWelcomeMessageEnabled(true);

    verify(setIsWelcomeMessageEnabledUseCaseMock(true));
  });
}
