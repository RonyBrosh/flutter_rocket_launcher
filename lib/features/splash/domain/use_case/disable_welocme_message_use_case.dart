import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';

abstract class DisableWelcomeMessageUseCase {
  DisableWelcomeMessageUseCase._();

  Future<ResultState<bool>> call();
}
