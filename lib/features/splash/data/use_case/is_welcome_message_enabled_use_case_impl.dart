import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/is_welcome_message_enabled_use_case.dart';

class IsWelcomeMessageEnabledUseCaseImpl implements IsWelcomeMessageEnabledUseCase {
  final SplashRepository _splashRepository;

  IsWelcomeMessageEnabledUseCaseImpl(this._splashRepository);

  @override
  Future<ResultState<bool>> call() {
    return _splashRepository.isWelcomeMessageEnabled();
  }
}
