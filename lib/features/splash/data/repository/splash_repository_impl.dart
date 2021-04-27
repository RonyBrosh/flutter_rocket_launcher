import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/cache/splash_cache.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashCache _splashCache;

  SplashRepositoryImpl(this._splashCache);

  Future<ResultState<bool>> isWelcomeMessageEnabled() {
    return _splashCache.isWelcomeMessageEnabled();
  }

  @override
  Future<ResultState<bool>> disableWelcomeMessage() {
    return _splashCache.disableWelcomeMessage();
  }
}
