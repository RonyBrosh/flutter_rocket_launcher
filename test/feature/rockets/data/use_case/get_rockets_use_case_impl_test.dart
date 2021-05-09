import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/rockets_repository.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/use_case/get_rockets_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RocketsRepositoryMock extends Mock implements RocketsRepository {}

void main() {
  final RocketsRepositoryMock rocketsRepositoryMock = RocketsRepositoryMock();
  final GetRocketsUseCaseImpl sut = GetRocketsUseCaseImpl(rocketsRepositoryMock);

  test('call SHOULD return result state success WHEN repository succeeds', () async {
    final List<Rocket> rockets = [Rocket.create(id: "1234")];
    when(rocketsRepositoryMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.success(rockets)));

    final ResultState<List<Rocket>> result = await sut();

    expect((result as Success).data, rockets);
  });

  test('call SHOULD return result state failure WHEN repository fails', () async {
    final ErrorType errorType = ErrorType.network();
    when(rocketsRepositoryMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<List<Rocket>> result = await sut();

    expect((result as Failure).errorType, errorType);
  });
}
