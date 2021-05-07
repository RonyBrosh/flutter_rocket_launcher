import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';

abstract class SetIsWelcomeMessageEnabledUseCase {
  SetIsWelcomeMessageEnabledUseCase._();

  Future<ResultState<bool>> call(bool isEnabled);
}
