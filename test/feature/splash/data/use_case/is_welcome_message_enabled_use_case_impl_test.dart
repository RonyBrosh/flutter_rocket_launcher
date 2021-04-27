import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_rocket_launcher/features/splash/data/use_case/is_welcome_message_enabled_use_case_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SplashRepositoryMock extends Mock implements SplashRepository {}

void main() {
  final SplashRepositoryMock splashRepositoryMock = SplashRepositoryMock();
  final IsWelcomeMessageEnabledUseCaseImpl sut = IsWelcomeMessageEnabledUseCaseImpl(splashRepositoryMock);

  test('call SHOULD return result state success WHEN repository succeeds', () async {
    final bool expected = true;
    when(splashRepositoryMock.isWelcomeMessageEnabled()).thenAnswer((realInvocation) => Future.value(ResultState.success(expected)));

    final ResultState<bool> result = await sut();

    expect((result as Success).data, expected);
  });

  test('call SHOULD return result state failure WHEN repository fails', () async {
    final ErrorType errorType = ErrorType.unknown();
    when(splashRepositoryMock.isWelcomeMessageEnabled()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<bool> result = await sut();

    expect((result as Failure).errorType, errorType);
  });
}
