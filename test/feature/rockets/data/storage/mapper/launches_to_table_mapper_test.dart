import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/launches_to_table_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final LaunchesToTableMapper sut = LaunchesToTableMapper();

  test('call SHOULD return mapped launches table WHEN invoked', () {
    final Launch launch = Launch.create(
      id: "id",
      rocketId: "rocketId",
      name: "name",
      imageUrl: "imageUrl",
      date: DateTime.fromMillisecondsSinceEpoch(1509392040 * 1000),
      isSuccessful: true,
    );
    final Map<String, Object> expected = {
      LaunchesDatabaseSqflite.COLUMN_ID: "id",
      LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: "rocketId",
      LaunchesDatabaseSqflite.COLUMN_NAME: "name",
      LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
      LaunchesDatabaseSqflite.COLUMN_DATE: 1509392040000,
      LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: 1,
    };

    final List<Map<String, Object>> result = sut(List.filled(1, launch));

    expect(result[0], expected);
  });
}
