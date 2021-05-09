import 'dart:convert';

import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketJsonToDomainListMapper implements Mapper<String, List<Rocket>> {
  @override
  List<Rocket> call(String input) {
    final List<dynamic> data = json.decode(input);
    return data
        .map((nextJsonObject) => Rocket.create(
            id: nextJsonObject['id'],
            name: nextJsonObject['name'],
            country: nextJsonObject['country'],
            description: nextJsonObject['description'],
            imageUrl: _getFirstImage(nextJsonObject),
            enginesCount: _getEnginesCount(nextJsonObject),
            isActive: nextJsonObject['active']))
        .toList(growable: false);
  }

  String _getFirstImage(dynamic nextJsonObject) {
    try {
      final List<String> imagesUrls = List.from(nextJsonObject['flickr_images'], growable: false);
      return imagesUrls[0];
    } catch (error) {
      return null;
    }
  }

  int _getEnginesCount(dynamic nextJsonObject) {
    try {
      return nextJsonObject['engines']['number'];
    } catch (error) {
      return null;
    }
  }
}
