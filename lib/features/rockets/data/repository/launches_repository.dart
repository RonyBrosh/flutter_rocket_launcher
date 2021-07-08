import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

abstract class LaunchesRepository {
  LaunchesRepository._();

  Future<ResultState<List<Launch>>> getLaunches(String rocketId, {bool isRefresh = false});
}
