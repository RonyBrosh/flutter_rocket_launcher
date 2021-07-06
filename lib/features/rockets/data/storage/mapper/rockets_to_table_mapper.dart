import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class RocketsToTableMapper implements Mapper<List<Rocket>, List<Map<String, Object>>> {
  @override
  List<Map<String, Object>> call(List<Rocket> input) {
    return input
        .map((rocket) => {
              RocketsDatabaseSqflite.COLUMN_ID: rocket.id,
              RocketsDatabaseSqflite.COLUMN_NAME: rocket.name,
              RocketsDatabaseSqflite.COLUMN_COUNTRY: rocket.country,
              RocketsDatabaseSqflite.COLUMN_DESCRIPTION: rocket.description,
              RocketsDatabaseSqflite.COLUMN_IMAGE_URL: rocket.imageUrl,
              RocketsDatabaseSqflite.COLUMN_ENGINES_COUNT: rocket.enginesCount,
              RocketsDatabaseSqflite.COLUMN_IS_ACTIVE: rocket.isActive ? 1 : 0,
            })
        .toList(growable: false);
  }
}
