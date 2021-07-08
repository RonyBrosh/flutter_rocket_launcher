import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketsHttpClient implements RocketsApi {
  final HttpClient _httpClient;
  final Mapper<Exception, ErrorType> _errorMapper;
  final Mapper<String, List<Rocket>> _rocketMapper;
  final Mapper<String, List<Launch>> _launchMapper;
  final Mapper<String, String> _getLaunchesRequestMapper;

  RocketsHttpClient(
    this._httpClient,
    this._rocketMapper,
    this._errorMapper,
    this._launchMapper,
    this._getLaunchesRequestMapper,
  );

  @override
  Future<ResultState<List<Rocket>>> getRockets() async {
    try {
      final String response = await _httpClient.get("/v4/rockets");
      final List<Rocket> result = _rocketMapper(response);
      return Future.value(ResultState.success(result));
    } on Exception catch (exception) {
      return Future.value(ResultState.failure(_errorMapper(exception)));
    }
  }

  @override
  Future<ResultState<List<Launch>>> getLaunches(String rocketId) async {
    try {
      final String response = await _httpClient.post(url: "/v4/launches/query", body: _getLaunchesRequestMapper(rocketId));
      final List<Launch> result = _launchMapper(response);
      return Future.value(ResultState.success(result));
    } on Exception catch (exception) {
      return Future.value(ResultState.failure(_errorMapper(exception)));
    }
  }
}
