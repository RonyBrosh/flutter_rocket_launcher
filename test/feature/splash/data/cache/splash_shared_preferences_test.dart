import 'package:flutter_rocket_launcher/core/data/storage/shared_preferences/shared_preferences_wrapper.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ErrorMapperMock extends Mock implements Mapper<Exception, ErrorType> {}

class SharedPreferencesWrapperMock extends Mock implements SharedPreferencesWrapper {}

void main() {
  final String key = "_isWelcomeMessageEnabledKey";
  final SharedPreferencesWrapperMock sharedPreferencesWrapperMock = SharedPreferencesWrapperMock();
  final ErrorMapperMock errorMapperMock = ErrorMapperMock();
  final SplashSharedPreferences sut = SplashSharedPreferences(sharedPreferencesWrapperMock, errorMapperMock);

  test('isWelcomeMessageEnabled SHOULD return result state success WHEN shared preferences wrapper succeeds', () async {
    final bool expected = false;
    when(sharedPreferencesWrapperMock.getBool(key, defaultValue: true)).thenAnswer((realInvocation) => Future.value(expected));

    final ResultState<bool> result = await sut.isWelcomeMessageEnabled();

    expect((result as Success).data, expected);
  });

  test('isWelcomeMessageEnabled SHOULD return result state failure WHEN shared preferences wrapper fails', () async {
    final Exception error = Exception();
    final ErrorType errorType = ErrorType.unknown();
    when(sharedPreferencesWrapperMock.getBool(key, defaultValue: true)).thenThrow(error);
    when(errorMapperMock(error)).thenAnswer((realInvocation) => errorType);

    final ResultState<bool> result = await sut.isWelcomeMessageEnabled();

    expect((result as Failure).errorType, errorType);
  });

  test('setIsWelcomeMessageEnabled SHOULD return result state success WHEN shared preferences wrapper succeeds', () async {
    final isEnabled = true;
    final bool expected = true;
    when(sharedPreferencesWrapperMock.setBool(key, isEnabled)).thenAnswer((realInvocation) => Future.value(expected));

    final ResultState<bool> result = await sut.setIsWelcomeMessageEnabled(isEnabled);

    expect((result as Success).data, expected);
  });

  test('setIsWelcomeMessageEnabled SHOULD return result state failure WHEN shared preferences wrapper fails', () async {
    final isEnabled = true;
    final Exception error = Exception();
    final ErrorType errorType = ErrorType.unknown();
    when(sharedPreferencesWrapperMock.setBool(key, isEnabled)).thenThrow(error);
    when(errorMapperMock(error)).thenAnswer((realInvocation) => errorType);

    final ResultState<bool> result = await sut.setIsWelcomeMessageEnabled(isEnabled);

    expect((result as Failure).errorType, errorType);
  });
}
