import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/launches_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RocketsApiMock extends Mock implements RocketsApi {}

class LaunchesDatabaseMock extends Mock implements LaunchesDatabase {}

class LaunchMock extends Mock implements Launch {}

void main() {
  late RocketsApiMock rocketsApiMock;
  late LaunchesDatabaseMock launchesDatabaseMock;
  late LaunchesRepositoryImpl sut;

  setUp(() {
    rocketsApiMock = RocketsApiMock();
    launchesDatabaseMock = LaunchesDatabaseMock();
    sut = LaunchesRepositoryImpl(rocketsApiMock, launchesDatabaseMock);
  });

  group("getLaunches", () {
    const String ROCKET_ID = "ROCKET_ID";

    test('getLaunches SHOULD return result state success WHEN isRefresh is false AND database succeeds', () async {
      final List<Launch> launches = List.filled(1, LaunchMock());
      when(() => launchesDatabaseMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.success(launches)));

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect(result is Success, true);
      expect((result as Success).data, launches);
      verifyZeroInteractions(rocketsApiMock);
    });

    test('getLaunches SHOULD return result state failure WHEN isRefresh is false AND database fails', () async {
      final ErrorType errorType = ErrorType.unknown();
      when(() => launchesDatabaseMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect(result is Failure, true);
      expect((result as Failure).errorType, errorType);
      verifyZeroInteractions(rocketsApiMock);
    });

    test('getLaunches SHOULD return result state success AND call api AND save launches to database WHEN isRefresh is true and API succeeds', () async {
      final List<Launch> launches = List.filled(1, LaunchMock());
      when(() => rocketsApiMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.success(launches)));
      when(() => launchesDatabaseMock.setLaunches(launches)).thenAnswer((realInvocation) => Future.value(true));

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID, isRefresh: true);

      expect(result is Success, true);
      expect((result as Success).data, launches);
      verify(() => launchesDatabaseMock.setLaunches(launches));
      verifyNever(() => launchesDatabaseMock.getLaunches(any<String>()));
    });

    test('getLaunches SHOULD return result state failure WHEN isRefresh is true and API fails', () async {
      final ErrorType errorType = ErrorType.network();
      when(() => rocketsApiMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID, isRefresh: true);

      expect(result is Failure, true);
      expect((result as Failure).errorType, errorType);
      verifyZeroInteractions(launchesDatabaseMock);
    });
  });
}
