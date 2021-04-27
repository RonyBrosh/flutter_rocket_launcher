import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';

abstract class RocketsApi {
  RocketsApi._();

  Future<ResultState<List<Rocket>>> getRockets();
}