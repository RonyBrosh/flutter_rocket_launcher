import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';

abstract class IsWelcomeMessageEnabledUseCase {
  IsWelcomeMessageEnabledUseCase._();

  Future<ResultState<bool>> call();
}
