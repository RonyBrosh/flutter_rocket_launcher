import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_cache.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SplashCacheMock extends Mock implements SplashCache {}

void main() {
  final isWelcomeMessageEnabled = true;
  final SplashCacheMock splashCacheMock = SplashCacheMock();
  final SplashRepositoryImpl sut = SplashRepositoryImpl(splashCacheMock);

  test('isWelcomeMessageEnabled SHOULD return result state success WHEN cache succeeds', () async {
    final bool expected = true;
    when(splashCacheMock.isWelcomeMessageEnabled()).thenAnswer((realInvocation) => Future.value(ResultState.success(expected)));

    final ResultState<bool> result = await sut.isWelcomeMessageEnabled();

    expect((result as Success).data, expected);
  });

  test('isWelcomeMessageEnabled SHOULD return result state failure WHEN cache fails', () async {
    final ErrorType errorType = ErrorType.unknown();
    when(splashCacheMock.isWelcomeMessageEnabled()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<bool> result = await sut.isWelcomeMessageEnabled();

    expect((result as Failure).errorType, errorType);
  });

  test('setIsWelcomeMessageEnabled SHOULD return result state success WHEN cache succeeds', () async {
    final bool expected = true;
    when(splashCacheMock.setIsWelcomeMessageEnabled(isWelcomeMessageEnabled)).thenAnswer((realInvocation) => Future.value(ResultState.success(expected)));

    final ResultState<bool> result = await sut.setIsWelcomeMessageEnabled(isWelcomeMessageEnabled);

    expect((result as Success).data, expected);
  });

  test('setIsWelcomeMessageEnabled SHOULD return result state failure WHEN cache fails', () async {
    final ErrorType errorType = ErrorType.unknown();
    when(splashCacheMock.setIsWelcomeMessageEnabled(isWelcomeMessageEnabled)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<bool> result = await sut.setIsWelcomeMessageEnabled(isWelcomeMessageEnabled);

    expect((result as Failure).errorType, errorType);
  });
}
