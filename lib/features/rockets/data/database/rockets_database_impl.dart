import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/database/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketsDatabaseImpl implements RocketsDatabase {
  @override
  Future<ResultState<List<Rocket>>> getRockets() {
    return Future.value(ResultState.success(List.empty()));
  }

  @override
  void setRockets(List<Rocket> rockets) {
    // TODO: implement setRockets
  }
}
