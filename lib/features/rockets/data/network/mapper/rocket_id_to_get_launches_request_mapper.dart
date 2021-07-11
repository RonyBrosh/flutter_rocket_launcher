import 'dart:convert';

import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';

class RocketIdToGetLaunchesRequestMapper implements Mapper<String, String> {
  @override
  String call(String input) {
    final request = <String, dynamic>{
      "query": <String, dynamic>{
        "rocket": input,
      },
    };

    return json.encode(request);
  }
}
