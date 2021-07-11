import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

class TableToLaunchesMapper implements Mapper<List<Map<String, Object?>>, List<Launch>> {
  @override
  List<Launch> call(List<Map<String, Object?>> input) {
    return input
        .map((row) => Launch.create(
              id: row[LaunchesDatabaseSqflite.COLUMN_ID] as String?,
              rocketId: row[LaunchesDatabaseSqflite.COLUMN_ROCKET_ID] as String?,
              name: row[LaunchesDatabaseSqflite.COLUMN_NAME] as String?,
              imageUrl: row[LaunchesDatabaseSqflite.COLUMN_IMAGE_URL] as String?,
              date: _getDateTime(row[LaunchesDatabaseSqflite.COLUMN_DATE] as int?),
              isSuccessful: row[LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL] == 1,
            ))
        .toList(growable: false);
  }

  DateTime _getDateTime(int? timestampInMilliseconds) {
    if (timestampInMilliseconds == null) {
      return DateTime.now();
    }

    return DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
  }
}
