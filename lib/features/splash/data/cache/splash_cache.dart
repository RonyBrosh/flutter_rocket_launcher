import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';

abstract class SplashCache {
  SplashCache._();

  Future<ResultState<bool>> isWelcomeMessageEnabled();

  Future<ResultState<bool>> setIsWelcomeMessageEnabled(bool isEnabled);
}
