import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketsDatabaseWeb implements RocketsDatabase {
  final List<Rocket> _rockets = List.empty(growable: true);

  @override
  Future<ResultState<List<Rocket>>> getRockets() {
    return Future.value(ResultState.success(_rockets));
  }

  @override
  Future<bool> setRockets(List<Rocket> rockets) {
    _rockets.clear();
    _rockets.addAll(rockets);
    return Future.value(true);
  }
}
