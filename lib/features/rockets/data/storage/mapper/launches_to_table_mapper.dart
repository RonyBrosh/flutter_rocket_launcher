import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

class LaunchesToTableMapper implements Mapper<List<Launch>, List<Map<String, Object>>> {
  @override
  List<Map<String, Object>> call(List<Launch> input) {
    return input
        .map((launch) => {
              LaunchesDatabaseSqflite.COLUMN_ID: launch.id,
              LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: launch.rocketId,
              LaunchesDatabaseSqflite.COLUMN_NAME: launch.name,
              LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: launch.imageUrl,
              LaunchesDatabaseSqflite.COLUMN_DATE: launch.date.millisecondsSinceEpoch,
              LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: launch.isSuccessful ? 1 : 0,
            })
        .toList(growable: false);
  }
}
