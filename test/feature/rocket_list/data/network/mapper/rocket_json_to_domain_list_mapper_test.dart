import 'dart:io';

import 'package:flutter_rocket_launcher/features/rocket_list/data/network/mapper/rocket_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rocket_list/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RocketJsonToDomainListMapper sut = RocketJsonToDomainListMapper();

  test('call SHOULD return mapped rocket list WHEN inout is valid', () async {
    final File file = File("test_resources/json/get_rockets_response_valid.json");
    final String input = await file.readAsString();
    final Rocket rocket = Rocket.create(
        id: "5e9d0d95eda69955f709d1eb",
        name: "Falcon 1",
        country: "Republic of the Marshall Islands",
        description:
            "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.",
        imageUrl: "https://imgur.com/DaCfMsj.jpg",
        enginesCount: 1,
        isActive: false);

    final List<Rocket> result = sut(input);

    expect(result[0], rocket);
  });

  test('call SHOULD return default rocket WHEN input is not valid', () async {
    final File file = File("test_resources/json/get_rockets_response_invalid.json");
    final String input = await file.readAsString();
    final Rocket rocket = Rocket.create();

    final List<Rocket> result = sut(input);

    expect(result[0], rocket);
  });
}
