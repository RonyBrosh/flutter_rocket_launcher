import 'dart:convert';
import 'dart:io';

import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_id_to_get_launches_request_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RocketIdToGetLaunchesRequestMapper sut = RocketIdToGetLaunchesRequestMapper();

  test('call SHOULD return mapped get launches request WHEN called', () async {
    final File file = File("test_resources/json/get_launches_request.json");
    final String expected = await file.readAsString();
    final String rocketId = json.decode(expected)['query']['rocket'];

    final String result = sut(rocketId);

    expect(result, expected);
  });
}
