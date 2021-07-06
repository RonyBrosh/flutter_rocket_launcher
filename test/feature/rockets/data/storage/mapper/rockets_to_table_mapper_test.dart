import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/rockets_to_table_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RocketsToTableMapper sut = RocketsToTableMapper();

  test('call SHOULD return mapped rockets table WHEN invoked', () {
    final Rocket rocket = Rocket.create(
      id: "id",
      name: "name",
      country: "country",
      description: "country",
      imageUrl: "imageUrl",
      enginesCount: 100,
      isActive: true,
    );
    final Map<String, Object> expected = {
      RocketsDatabaseSqflite.COLUMN_ID: "id",
      RocketsDatabaseSqflite.COLUMN_NAME: "name",
      RocketsDatabaseSqflite.COLUMN_COUNTRY: "country",
      RocketsDatabaseSqflite.COLUMN_DESCRIPTION: "country",
      RocketsDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
      RocketsDatabaseSqflite.COLUMN_ENGINES_COUNT: 100,
      RocketsDatabaseSqflite.COLUMN_IS_ACTIVE: 1,
    };
    final List<Map<String, Object>> result = sut(List.filled(1, rocket));

    expect(result[0], expected);
  });
}
