import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_rocket_launcher/features/splash/domain/use_case/disable_welocme_message_use_case.dart';

class DisableWelcomeMessageUseCaseImpl implements DisableWelcomeMessageUseCase {
  final SplashRepository _splashRepository;

  DisableWelcomeMessageUseCaseImpl(this._splashRepository);

  @override
  Future<ResultState<bool>> call() {
    return _splashRepository.disableWelcomeMessage();
  }
}
