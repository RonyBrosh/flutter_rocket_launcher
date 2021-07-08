import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/launches_repository.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_launches_use_case.dart';

class GetLaunchesUseCaseImpl implements GetLaunchesUseCase {
  final LaunchesRepository _launchesRepository;

  GetLaunchesUseCaseImpl(this._launchesRepository);

  @override
  Future<ResultState<List<Launch>>> call(String rocketId, {bool isRefresh = false}) {
    return _launchesRepository.getLaunches(rocketId);
  }
}
