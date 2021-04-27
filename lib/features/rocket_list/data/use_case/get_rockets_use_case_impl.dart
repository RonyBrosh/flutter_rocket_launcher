import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/repository/rockets_repository.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/use_case/get_rockets_use_case.dart';

class GetRocketsUseCaseImpl implements GetRocketsUseCase {
  final RocketsRepository _rocketsRepository;

  GetRocketsUseCaseImpl(this._rocketsRepository);

  @override
  Future<ResultState<List<Rocket>>> call() {
    return _rocketsRepository.getRockets();
  }
}
