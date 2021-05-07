import 'package:flutter_rocket_launcher/core/data/storage/shared_preferences/shared_preferences_wrapper.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_cache.dart';

class SplashSharedPreferences implements SplashCache {
  final String _isWelcomeMessageEnabledKey = "_isWelcomeMessageEnabledKey";
  final SharedPreferencesWrapper _sharedPreferencesWrapper;
  final Mapper<Exception, ErrorType> _errorMapper;

  SplashSharedPreferences(this._sharedPreferencesWrapper, this._errorMapper);

  @override
  Future<ResultState<bool>> isWelcomeMessageEnabled() async {
    try {
      final bool isWelcomeMessageEnabled = await _sharedPreferencesWrapper.getBool(_isWelcomeMessageEnabledKey, defaultValue: true);
      return Future.value(ResultState.success(isWelcomeMessageEnabled));
    } catch (exception) {
      return Future.value(ResultState.failure(_errorMapper(exception)));
    }
  }

  @override
  Future<ResultState<bool>> setIsWelcomeMessageEnabled(bool isEnabled) async {
    try {
      final bool result = await _sharedPreferencesWrapper.setBool(_isWelcomeMessageEnabledKey, isEnabled);
      return Future.value(ResultState.success(result));
    } catch (exception) {
      return Future.value(ResultState.failure(_errorMapper(exception)));
    }
  }
}
