import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/repository/rockets_repository.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';

class RocketsRepositoryImpl implements RocketsRepository {
  final RocketsApi _rocketsApi;

  RocketsRepositoryImpl(this._rocketsApi);

  Future<ResultState<List<Rocket>>> getRockets() {
    return _rocketsApi.getRockets();
  }
}
