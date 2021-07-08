import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/launches_repository.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/use_case/get_launches_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LaunchesRepositoryMock extends Mock implements LaunchesRepository {}

class LaunchMock extends Mock implements Launch {}

void main() {
  const String ROCKET_ID = "ROCKET_ID";

  final LaunchesRepositoryMock launchesRepositoryMock = LaunchesRepositoryMock();
  final GetLaunchesUseCaseImpl sut = GetLaunchesUseCaseImpl(launchesRepositoryMock);

  test('call SHOULD return result state success WHEN repository succeeds', () async {
    final List<Launch> launches = List.filled(1, LaunchMock());
    when(() => launchesRepositoryMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.success(launches)));

    final ResultState<List<Launch>> result = await sut(ROCKET_ID);

    expect((result as Success).data, launches);
  });

  test('call SHOULD return result state failure WHEN repository fails', () async {
    final ErrorType errorType = ErrorType.network();
    when(() => launchesRepositoryMock.getLaunches(ROCKET_ID)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    final ResultState<List<Launch>> result = await sut(ROCKET_ID);

    expect((result as Failure).errorType, errorType);
  });
}
