import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/set_is_welocme_message_enabled_use_case.dart';

class SetIsWelcomeMessageEnabledUseCaseImpl implements SetIsWelcomeMessageEnabledUseCase {
  final SplashRepository _splashRepository;

  SetIsWelcomeMessageEnabledUseCaseImpl(this._splashRepository);

  @override
  Future<ResultState<bool>> call(bool isEnabled) {
    return _splashRepository.setIsWelcomeMessageEnabled(isEnabled);
  }
}
