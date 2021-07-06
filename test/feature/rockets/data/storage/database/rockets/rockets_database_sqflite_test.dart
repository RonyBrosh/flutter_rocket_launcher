import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ErrorMapperMock extends Mock implements Mapper<Exception, ErrorType> {}

class RocketsToTableMapperMock extends Mock implements Mapper<List<Rocket>, List<Map<String, Object>>> {}

class TableToRocketsMapperMock extends Mock implements Mapper<List<Map<String, Object?>>, List<Rocket>> {}

void main() async {
  final Database database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  await database.execute(RocketsDatabaseSqflite.CREATE_TABLE);

  final ErrorMapperMock _errorMapperMock = ErrorMapperMock();
  final RocketsToTableMapperMock _rocketsToTableMapperMock = RocketsToTableMapperMock();
  final TableToRocketsMapperMock _tableToRocketsMapperMock = TableToRocketsMapperMock();

  final RocketsDatabaseSqflite sut = RocketsDatabaseSqflite(
    database,
    _errorMapperMock,
    _rocketsToTableMapperMock,
    _tableToRocketsMapperMock,
  );

  group('getRockets', () {
    test('getRockets SHOULD return result state failure WHEN exception is thrown', () async {
      final Exception exception = Exception("Error query database");
      final ErrorType errorType = ErrorType.unknown();
      when(() => _tableToRocketsMapperMock(any<List<Map<String, Object?>>>())).thenThrow(exception);
      when(() => _errorMapperMock(exception)).thenReturn(errorType);

      final ResultState<List<Rocket>> result = await sut.getRockets();

      expect((result as Failure).errorType, errorType);
    });

    test('getRockets SHOULD return result state success WHEN query rockets succeeds', () async {
      final List<Rocket> rockets = List.filled(1, Rocket.create(id: "id"));
      final row = {
        "id": "id",
        "name": "name",
        "country": "country",
        "description": "description",
        "imageUrl": "imageUrl",
        "enginesCount": 100,
        "isActive": 1,
      };
      final List<Map<String, Object>> table = List.filled(1, row);
      when(() => _rocketsToTableMapperMock(rockets)).thenReturn(table);
      when(() => _tableToRocketsMapperMock(table)).thenReturn(rockets);
      await database.insert("Rockets", row);

      final ResultState<List<Rocket>> result = await sut.getRockets();

      expect((result as Success).data, rockets);
    });
  });

  test('setRockets SHOULD save rockets to database WHEN called', () async {
    final List<Rocket> rockets = List.filled(1, Rocket.create(id: "id"));
    final List<Map<String, Object>> table = List.filled(1, {
      "id": "id",
      "name": "name",
      "country": "country",
      "description": "description",
      "imageUrl": "imageUrl",
      "enginesCount": 100,
      "isActive": 1,
    });
    when(() => _rocketsToTableMapperMock(rockets)).thenReturn(table);

    bool result = await sut.setRockets(rockets);

    expect(result, true);
  });
}
