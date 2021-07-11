import 'dart:convert';

import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

class LaunchesJsonToDomainListMapper implements Mapper<String, List<Launch>> {
  @override
  List<Launch> call(String input) {
    final List<dynamic> data = json.decode(input)['docs'];
    return data
        .map((nextJsonObject) => Launch.create(
            id: nextJsonObject['id'],
            rocketId: nextJsonObject['rocket'],
            name: nextJsonObject['name'],
            imageUrl: nextJsonObject['links']['patch']['small'],
            date: _getDateTime(nextJsonObject),
            isSuccessful: nextJsonObject['success']))
        .toList(growable: false);
  }

  DateTime _getDateTime(dynamic nextJsonObject) {
    final int? timestampInSeconds = nextJsonObject['date_unix'];
    if (timestampInSeconds == null) {
      return DateTime.now();

    }
    return DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
  }
}
