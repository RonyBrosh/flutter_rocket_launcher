import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';

abstract class SplashRepository {
  SplashRepository._();

  Future<ResultState<bool>> isWelcomeMessageEnabled();

  Future<ResultState<bool>> disableWelcomeMessage();
}
