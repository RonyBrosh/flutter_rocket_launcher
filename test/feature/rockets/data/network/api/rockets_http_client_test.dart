import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

class RocketMapperMock extends Mock implements Mapper<String, List<Rocket>> {}

class ErrorMapperMock extends Mock implements Mapper<Exception, ErrorType> {}

class LaunchMapperMock extends Mock implements Mapper<String, List<Launch>> {}

class GetLaunchesRequestMapperMock extends Mock implements Mapper<String, String> {}

class LaunchMock extends Mock implements Launch {}

void main() {
  final HttpClientMock httpClientMock = HttpClientMock();
  final RocketMapperMock rocketMapperMock = RocketMapperMock();
  final ErrorMapperMock errorMapperMock = ErrorMapperMock();
  final Mapper<String, List<Launch>> launchMapper = LaunchMapperMock();
  final Mapper<String, String> getLaunchesRequestMapper = GetLaunchesRequestMapperMock();

  final RocketsHttpClient sut = RocketsHttpClient(
    httpClientMock,
    errorMapperMock,
    rocketMapperMock,
    launchMapper,
    getLaunchesRequestMapper,
  );

  group("getRockets", () {
    final String getRocketRequestUrl = "/v4/rockets";

    test('getRockets SHOULD return result state success WHEN http client succeeds', () async {
      final String body = "body";
      final Rocket rocket = Rocket.create();
      final List<Rocket> rockets = [rocket];
      when(() => httpClientMock.get(getRocketRequestUrl)).thenAnswer((realInvocation) => Future.value(body));
      when(() => rocketMapperMock(body)).thenReturn(rockets);

      final ResultState<List<Rocket>> result = await sut.getRockets();

      expect((result as Success).data, rockets);
    });

    test('getRockets SHOULD return result state failure WHEN http client fails', () async {
      final Exception error = Exception();
      final ErrorType errorType = ErrorType.network();
      when(() => httpClientMock.get(getRocketRequestUrl)).thenThrow(error);
      when(() => errorMapperMock(error)).thenAnswer((realInvocation) => errorType);

      final ResultState<List<Rocket>> result = await sut.getRockets();

      expect((result as Failure).errorType, errorType);
    });
  });

  group("getLaunches", () {
    const String GET_LAUNCHES_URL = "/v4/launches/query";
    const String ROCKET_ID = "ROCKET_ID";

    test('getLaunches SHOULD return result state success WHEN http client succeeds', () async {
      final String response = "response";
      final String request = "request";
      final List<Launch> launches = [LaunchMock()];
      when(() => httpClientMock.post(url: GET_LAUNCHES_URL, body: request)).thenAnswer((realInvocation) => Future.value(response));
      when(() => getLaunchesRequestMapper(ROCKET_ID)).thenReturn(request);
      when(() => launchMapper(response)).thenReturn(launches);

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect((result as Success).data, launches);
    });

    test('getLaunches SHOULD return result state failure WHEN http client fails', () async {
      final Exception error = Exception();
      final ErrorType errorType = ErrorType.network();
      final String request = "request";
      when(() => httpClientMock.post(url: GET_LAUNCHES_URL, body: request)).thenThrow(error);
      when(() => getLaunchesRequestMapper(ROCKET_ID)).thenReturn(request);
      when(() => errorMapperMock(error)).thenAnswer((realInvocation) => errorType);

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect((result as Failure).errorType, errorType);
    });
  });
}
