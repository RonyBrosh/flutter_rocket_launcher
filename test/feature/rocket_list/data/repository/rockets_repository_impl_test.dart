import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/repository/rockets_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RocketsApiMock extends Mock implements RocketsApi {}

void main() {
  final RocketsApiMock rocketsApiMock = RocketsApiMock();
  final RocketsRepositoryImpl sut = RocketsRepositoryImpl(rocketsApiMock);

  test('getRockets SHOULD return result state success WHEN api succeeds', () async {
    final List<Rocket> rockets = [Rocket.create(id: "1234")];
    when(rocketsApiMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.success(rockets)));

    final ResultState<List<Rocket>> result = await sut.getRockets();

    expect(result is Success, true);
    expect((result as Success).data, rockets);
  });

  test('getRockets SHOULD return result state failure WHEN api fails', () async {
    final ErrorType errorType = ErrorType.network();
    when(rocketsApiMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<List<Rocket>> result = await sut.getRockets();

    expect(result is Failure, true);
    expect((result as Failure).errorType, errorType);
  });
}
