import 'package:fake_async/fake_async.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/rockets_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RocketsApiMock extends Mock implements RocketsApi {}

class RocketsDatabaseMock extends Mock implements RocketsDatabase {}

void main() {
  RocketsApiMock rocketsApiMock;
  RocketsDatabaseMock rocketsDatabaseMock;
  RocketsRepositoryImpl sut;

  setUp(() {
    rocketsApiMock = RocketsApiMock();
    rocketsDatabaseMock = RocketsDatabaseMock();
    sut = RocketsRepositoryImpl(rocketsApiMock, rocketsDatabaseMock);
  });

  test('getRockets SHOULD call database WHEN isRefresh is false', () {
    sut.getRockets();

    verify(rocketsDatabaseMock.getRockets());
    verifyZeroInteractions(rocketsApiMock);
  });

  test('getRockets SHOULD call api AND save rockets database WHEN isRefresh is true and API succeeds', () {
    final List<Rocket> rockets = [Rocket.create(id: "1234")];
    when(rocketsApiMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.success(rockets)));

    fakeAsync((async) {
      sut.getRockets(isRefresh: true);

      async.flushMicrotasks();
      verify(rocketsApiMock.getRockets());
      verify(rocketsDatabaseMock.setRockets(rockets));
      verifyNever(rocketsDatabaseMock.getRockets());
    });
  });

  test('getRockets SHOULD return result state success WHEN database succeeds', () async {
    final List<Rocket> rockets = [Rocket.create(id: "1234")];
    when(rocketsDatabaseMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.success(rockets)));

    final ResultState<List<Rocket>> result = await sut.getRockets();

    expect(result is Success, true);
    expect((result as Success).data, rockets);
    verifyZeroInteractions(rocketsApiMock);
  });

  test('getRockets SHOULD return result state failure WHEN database fails', () async {
    final ErrorType errorType = ErrorType.network();
    when(rocketsDatabaseMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<List<Rocket>> result = await sut.getRockets();

    expect(result is Failure, true);
    expect((result as Failure).errorType, errorType);
  });

  test('getRockets SHOULD return result state success WHEN api succeeds', () async {
    final List<Rocket> rockets = [Rocket.create(id: "1234")];
    when(rocketsApiMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.success(rockets)));

    final ResultState<List<Rocket>> result = await sut.getRockets(isRefresh: true);

    expect(result is Success, true);
    expect((result as Success).data, rockets);
  });

  test('getRockets SHOULD return result state failure WHEN api fails', () async {
    final ErrorType errorType = ErrorType.network();
    when(rocketsApiMock.getRockets()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<List<Rocket>> result = await sut.getRockets(isRefresh: true);

    expect(result is Failure, true);
    expect((result as Failure).errorType, errorType);
  });
}
