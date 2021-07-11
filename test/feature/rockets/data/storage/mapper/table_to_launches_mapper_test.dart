import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/table_to_launches_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TableToLaunchesMapper sut = TableToLaunchesMapper();

  test('call SHOULD return mapped launches WHEN invoked with valid input', () {
    final Map<String, Object?> input = {
      LaunchesDatabaseSqflite.COLUMN_ID: "id",
      LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: "rocketId",
      LaunchesDatabaseSqflite.COLUMN_NAME: "name",
      LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
      LaunchesDatabaseSqflite.COLUMN_DATE: 1509392040000,
      LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: 1,
    };
    final Launch expected = Launch.create(
      id: "id",
      rocketId: "rocketId",
      name: "name",
      imageUrl: "imageUrl",
      date: DateTime.fromMillisecondsSinceEpoch(1509392040000),
      isSuccessful: true,
    );

    final List<Launch> result = sut(List.filled(1, input));

    expect(result[0], expected);
  });

  test('call SHOULD return mapped default launches WHEN invoked with invalid input', () {
    final Map<String, Object?> input = {
      LaunchesDatabaseSqflite.COLUMN_ID: null,
      LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: null,
      LaunchesDatabaseSqflite.COLUMN_NAME: null,
      LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: null,
      LaunchesDatabaseSqflite.COLUMN_DATE: null,
      LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: null,
    };
    final Launch expected = Launch.create();

    final List<Launch> result = sut(List.filled(1, input));

    expect(result[0], expected);
  });
}
