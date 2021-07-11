import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ErrorMapperMock extends Mock implements Mapper<Exception, ErrorType> {}

class LaunchesToTableMapperMock extends Mock implements Mapper<List<Launch>, List<Map<String, Object>>> {}

class TableToLaunchesMapperMock extends Mock implements Mapper<List<Map<String, Object?>>, List<Launch>> {}

void main() async {
  final Database database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  await database.execute(LaunchesDatabaseSqflite.CREATE_TABLE);

  final ErrorMapperMock _errorMapperMock = ErrorMapperMock();
  final LaunchesToTableMapperMock _launchesToTableMapperMock = LaunchesToTableMapperMock();
  final TableToLaunchesMapperMock _tableToLaunchesMapperMock = TableToLaunchesMapperMock();

  final LaunchesDatabaseSqflite sut = LaunchesDatabaseSqflite(
    Future.value(database),
    _errorMapperMock,
    _launchesToTableMapperMock,
    _tableToLaunchesMapperMock,
  );

  group('getLaunches', () {
    const String ROCKET_ID = "ROCKET_ID";

    test('getLaunches SHOULD return result state failure WHEN exception is thrown', () async {
      final Exception exception = Exception("Error query database");
      final ErrorType errorType = ErrorType.unknown();
      when(() => _tableToLaunchesMapperMock(any<List<Map<String, Object?>>>())).thenThrow(exception);
      when(() => _errorMapperMock(exception)).thenReturn(errorType);

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect((result as Failure).errorType, errorType);
    });

    test('getLaunches SHOULD return result state success WHEN query launches succeeds', () async {
      final List<Launch> launches = List.filled(1, Launch.create(id: "id"));
      final row = {
        LaunchesDatabaseSqflite.COLUMN_ID: "id",
        LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: "rocketId",
        LaunchesDatabaseSqflite.COLUMN_NAME: "name",
        LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
        LaunchesDatabaseSqflite.COLUMN_DATE: 0,
        LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: 1,
      };
      final List<Map<String, Object>> table = List.filled(1, row);
      when(() => _launchesToTableMapperMock(launches)).thenReturn(table);
      when(() => _tableToLaunchesMapperMock(table)).thenReturn(launches);
      await database.insert(LaunchesDatabaseSqflite.TABLE_NAME, row);

      final ResultState<List<Launch>> result = await sut.getLaunches(ROCKET_ID);

      expect((result as Success).data, launches);
    });
  });

  test('setRockets SHOULD save rockets to database WHEN called', () async {
    final List<Launch> launches = List.filled(1, Launch.create(id: "id"));
    final List<Map<String, Object>> table = List.filled(1, {
      LaunchesDatabaseSqflite.COLUMN_ID: "id",
      LaunchesDatabaseSqflite.COLUMN_ROCKET_ID: "rocketId",
      LaunchesDatabaseSqflite.COLUMN_NAME: "name",
      LaunchesDatabaseSqflite.COLUMN_IMAGE_URL: "imageUrl",
      LaunchesDatabaseSqflite.COLUMN_DATE: 0,
      LaunchesDatabaseSqflite.COLUMN_IS_SUCCESSFUL: 1,
    });
    when(() => _launchesToTableMapperMock(launches)).thenReturn(table);

    bool result = await sut.setLaunches(launches);

    expect(result, true);
  });
}
