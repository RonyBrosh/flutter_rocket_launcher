import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/data/network/api/rockets_api.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';

class RocketsHttpClient implements RocketsApi {
  final HttpClient _httpClient;
  final Mapper<String, List<Rocket>> _rocketMapper;
  final Mapper<Exception, ErrorType> _errorMapper;

  RocketsHttpClient(this._httpClient, this._rocketMapper, this._errorMapper);

  @override
  Future<ResultState<List<Rocket>>> getRockets() async {
    try {
      final String response = await _httpClient.get("v4/rockets");
      final List<Rocket> result = _rocketMapper(response);
      return Future.value(ResultState.success(result));
    } catch (exception) {
      return Future.value(ResultState.failure(_errorMapper(exception)));
    }
  }
}
