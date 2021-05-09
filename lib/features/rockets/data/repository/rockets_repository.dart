import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

abstract class RocketsRepository {
  RocketsRepository._();

  Future<ResultState<List<Rocket>>> getRockets({bool isRefresh = false});
}
