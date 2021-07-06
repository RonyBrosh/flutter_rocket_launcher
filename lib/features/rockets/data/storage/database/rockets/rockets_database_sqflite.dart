import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:sqflite/sqflite.dart';

class RocketsDatabaseSqflite implements RocketsDatabase {
  static const String TABLE_NAME = "Rockets";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_COUNTRY = "country";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_IMAGE_URL = "imageUrl";
  static const String COLUMN_ENGINES_COUNT = "enginesCount";
  static const String COLUMN_IS_ACTIVE = "isActive";

  static const String CREATE_TABLE = '''CREATE TABLE $TABLE_NAME (
  $COLUMN_ID TEXT PRIMARY KEY, 
  $COLUMN_NAME TEXT NOT NULL,
  $COLUMN_COUNTRY TEXT NOT NULL,
  $COLUMN_DESCRIPTION TEXT NOT NULL,
  $COLUMN_IMAGE_URL TEXT NOT NULL, 
  $COLUMN_ENGINES_COUNT INTEGER NOT NULL,
  $COLUMN_IS_ACTIVE BOOLEAN NOT NULL
  )''';

  final Future<Database> _database;
  final Mapper<Exception, ErrorType> _errorMapper;
  final Mapper<List<Rocket>, List<Map<String, Object>>> _rocketsToTableMapper;
  final Mapper<List<Map<String, Object?>>, List<Rocket>> _tableToRocketsMapper;

  RocketsDatabaseSqflite(
    this._database,
    this._errorMapper,
    this._rocketsToTableMapper,
    this._tableToRocketsMapper,
  );

  @override
  Future<ResultState<List<Rocket>>> getRockets() async {
    try {
      Database database = await _database;
      List<Map<String, Object?>> table = await database.query(TABLE_NAME);
      List<Rocket> rockets = _tableToRocketsMapper(table);
      return ResultState.success(rockets);
    } on Exception catch (exception) {
      return ResultState.failure(_errorMapper(exception));
    }
  }

  @override
  Future<bool> setRockets(List<Rocket> rockets) async {
    try {
      Database database = await _database;
      Batch batch = database.batch();
      List<Map<String, Object>> table = _rocketsToTableMapper(rockets);
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
