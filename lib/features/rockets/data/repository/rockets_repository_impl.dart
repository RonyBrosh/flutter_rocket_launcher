import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/database/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/rockets_repository.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketsRepositoryImpl implements RocketsRepository {
  final RocketsApi _rocketsApi;
  final RocketsDatabase _rocketsDatabase;

  RocketsRepositoryImpl(this._rocketsApi, this._rocketsDatabase);

  Future<ResultState<List<Rocket>>> getRockets({bool isRefresh = false}) {
    if (isRefresh) {
      return _rocketsApi.getRockets().then((resultState) {
        if (resultState is Success) {
          _rocketsDatabase.setRockets((resultState as Success).data);
        }
        return Future.value(resultState);
      });
    } else {
      return _rocketsDatabase.getRockets();
    }
  }
}
