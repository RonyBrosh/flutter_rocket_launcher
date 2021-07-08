import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/launches_repository.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

class LaunchesRepositoryImpl implements LaunchesRepository {
  final RocketsApi _rocketsApi;
  final LaunchesDatabase _launchesDatabase;

  LaunchesRepositoryImpl(this._rocketsApi, this._launchesDatabase);

  @override
  Future<ResultState<List<Launch>>> getLaunches(String rocketId, {bool isRefresh = false}) {
    if (isRefresh) {
      return _rocketsApi.getLaunches(rocketId).then((resultState) {
        if (resultState is Success) {
          _launchesDatabase.setLaunches((resultState as Success).data);
        }
        return Future.value(resultState);
      });
    } else {
      return _launchesDatabase.getLaunches(rocketId);
    }
  }
}
