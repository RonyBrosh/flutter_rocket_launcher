import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

class TableToRocketsMapper implements Mapper<List<Map<String, Object?>>, List<Rocket>> {
  @override
  List<Rocket> call(List<Map<String, Object?>> input) {
    return input
        .map((row) => Rocket.create(
              id: row[RocketsDatabaseSqflite.COLUMN_ID] as String?,
              name: row[RocketsDatabaseSqflite.COLUMN_NAME] as String?,
              country: row[RocketsDatabaseSqflite.COLUMN_COUNTRY] as String?,
              description: row[RocketsDatabaseSqflite.COLUMN_DESCRIPTION] as String?,
              imageUrl: row[RocketsDatabaseSqflite.COLUMN_IMAGE_URL] as String?,
              enginesCount: row[RocketsDatabaseSqflite.COLUMN_ENGINES_COUNT] as int?,
              isActive: row[RocketsDatabaseSqflite.COLUMN_IS_ACTIVE] == 1,
            ))
        .toList(growable: false);
  }
}
