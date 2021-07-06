import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/table_to_rockets_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TableToRocketsMapper sut = TableToRocketsMapper();

  test('call SHOULD return mapped rockets WHEN invoked with valid input', () {
    final Map<String, Object?> input = {
      RocketsDatabaseSqflite.COLUMN_ID: "id",
      RocketsDatabaseSqflite.COLUMN_NAME: "name",
      RocketsDatabaseSqflite.COLUMN_COUNTRY: "country",
      RocketsDatabaseSqflite.COLUMN_DESCRIPTION: "country",
      RocketsDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
      RocketsDatabaseSqflite.COLUMN_ENGINES_COUNT: 100,
      RocketsDatabaseSqflite.COLUMN_IS_ACTIVE: 1,
    };
    final Rocket expected = Rocket.create(
      id: "id",
      name: "name",
      country: "country",
      description: "country",
      imageUrl: "imageUrl",
      enginesCount: 100,
      isActive: true,
    );

    final List<Rocket> result = sut(List.filled(1, input));

    expect(result[0], expected);
  });

  test('call SHOULD return mapped default rockets WHEN invoked with invalid input', () {
    final Map<String, Object?> input = {
      RocketsDatabaseSqflite.COLUMN_ID: null,
      RocketsDatabaseSqflite.COLUMN_NAME: null,
      RocketsDatabaseSqflite.COLUMN_COUNTRY: null,
      RocketsDatabaseSqflite.COLUMN_DESCRIPTION: null,
      RocketsDatabaseSqflite.COLUMN_IMAGE_URL: null,
      RocketsDatabaseSqflite.COLUMN_ENGINES_COUNT: null,
      RocketsDatabaseSqflite.COLUMN_IS_ACTIVE: null,
    };
    final Rocket expected = Rocket.create();

    final List<Rocket> result = sut(List.filled(1, input));

    expect(result[0], expected);
  });
}
