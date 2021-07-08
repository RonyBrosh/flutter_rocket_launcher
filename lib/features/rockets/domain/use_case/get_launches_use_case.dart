import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

abstract class GetLaunchesUseCase {
  GetLaunchesUseCase._();

  Future<ResultState<List<Launch>>> call(String rocketId, {bool isRefresh = false});
}
