import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:sqflite/sqflite.dart';

class RocketsDatabaseSqflite implements RocketsDatabase {
  static const String _tableName = "Rockets";
  static const String _id = "id";
  static const String _name = "name";
  static const String _country = "country";
  static const String _description = "description";
  static const String _imageUrl = "imageUrl";
  static const String _enginesCount = "enginesCount";
  static const String _isActive = "isActive";

  static const String CREATE_TABLE = '''CREATE TABLE $_tableName (
  $_id TEXT PRIMARY KEY, 
  $_name TEXT NOT NULL,
  $_country TEXT NOT NULL,
  $_description TEXT NOT NULL,
  $_imageUrl TEXT NOT NULL, 
  $_enginesCount INTEGER NOT NULL,
  $_isActive BOOLEAN NOT NULL
  )''';

  final Database _database;
  final Mapper<Exception, ErrorType> _errorMapper;
  final Mapper<List<Rocket>, List<Map<String, Object>>> _rocketsToTableMapper;
  final Mapper<List<Map<String, Object?>>, List<Rocket>> _tableToRocketsMapper;

  RocketsDatabaseSqflite(this._database, this._errorMapper, this._rocketsToTableMapper, this._tableToRocketsMapper);

  @override
  Future<ResultState<List<Rocket>>> getRockets() async {
    try {
      List<Map<String, Object?>> table = await _database.query(_tableName);
      List<Rocket> rockets = _tableToRocketsMapper(table);
      return ResultState.success(rockets);
    } on Exception catch (exception) {
      return ResultState.failure(_errorMapper(exception));
    }
  }

  @override
  Future<bool> setRockets(List<Rocket> rockets) async {
    try {
      Batch batch = _database.batch();
      List<Map<String, Object>> table = _rocketsToTableMapper(rockets);
      table.forEach((row) {
        batch.insert(_tableName, row);
      });
      List result = await batch.commit();
      return result.isNotEmpty;
    } on Exception {
      return false;
    }
  }
}
