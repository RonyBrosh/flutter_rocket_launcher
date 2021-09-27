import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:sqflite/sqflite.dart';

class LaunchesDatabaseSqflite implements LaunchesDatabase {
  static const String TABLE_NAME = "Launches";
  static const String COLUMN_ID = "id";
  static const String COLUMN_ROCKET_ID = "rocketId";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_IMAGE_URL = "imageUrl";
  static const String COLUMN_DATE = "date";
  static const String COLUMN_IS_SUCCESSFUL = "isSuccessful";

  static const String CREATE_TABLE = '''CREATE TABLE $TABLE_NAME (
  $COLUMN_ID TEXT PRIMARY KEY, 
  $COLUMN_ROCKET_ID TEXT NOT NULL,
  $COLUMN_NAME TEXT NOT NULL,
  $COLUMN_IMAGE_URL TEXT NOT NULL, 
  $COLUMN_DATE INTEGER NOT NULL,
  $COLUMN_IS_SUCCESSFUL BOOLEAN NOT NULL
  )''';

  final Future<Database> _database;
  final Mapper<Exception, ErrorType> _errorMapper;
  final Mapper<List<Launch>, List<Map<String, Object>>> _launchesToTableMapper;
  final Mapper<List<Map<String, Object?>>, List<Launch>> _tableToLaunchesMapper;

  LaunchesDatabaseSqflite(
    this._database,
    this._errorMapper,
    this._launchesToTableMapper,
    this._tableToLaunchesMapper,
  );

  @override
  Future<ResultState<List<Launch>>> getLaunches(String rocketId) async {
    try {
      Database database = await _database;
      List<Map<String, Object?>> table = await database.query(
        TABLE_NAME,
        where: "$COLUMN_ROCKET_ID=?",
        whereArgs: [rocketId],
      );
      List<Launch> rockets = _tableToLaunchesMapper(table);
      return ResultState.success(rockets);
    } on Exception catch (exception) {
      return ResultState.failure(_errorMapper(exception));
    }
  }

  @override
  Future<bool> setLaunches(List<Launch> launches) async {
    try {
      Database database = await _database;
      Batch batch = database.batch();
      List<Map<String, Object>> table = _launchesToTableMapper(launches);
      table.forEach((row) {
        batch.insert(TABLE_NAME, row, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      List result = await batch.commit();
      return result.isNotEmpty;
    } on Exception {
      return false;
    }
  }
}
