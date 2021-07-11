import 'dart:io';

import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/launches_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final LaunchesJsonToDomainListMapper sut = LaunchesJsonToDomainListMapper();

  test('call SHOULD return mapped launch list WHEN input is valid', () async {
    final File file = File("test_resources/json/get_launches_response_valid.json");
    final String input = await file.readAsString();
    final Launch launch = Launch.create(
      id: "5eb87d0dffd86e000604b35b",
      rocketId: "5e9d0d95eda69973a809d1ec",
      name: "KoreaSat 5A",
      imageUrl: "https://images2.imgbox.com/02/51/7NLaBm8c_o.png",
      date: DateTime.fromMillisecondsSinceEpoch(1509392040 * 1000),
      isSuccessful: true,
    );

    final List<Launch> result = sut(input);

    expect(result[0], launch);
  });

  test('call SHOULD return default launch WHEN input is not valid', () async {
    final File file = File("test_resources/json/get_launches_response_invalid.json");
    final String input = await file.readAsString();
    final Launch launch = Launch.create();

    final List<Launch> result = sut(input);

    expect(result[0], launch);
  });
}
