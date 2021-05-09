import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

abstract class GetRocketsUseCase {
  GetRocketsUseCase._();

  Future<ResultState<List<Rocket>>> call({bool isRefresh = false});
}
