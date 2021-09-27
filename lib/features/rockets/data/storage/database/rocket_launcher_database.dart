import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RocketLauncherDatabase {
  static final RocketLauncherDatabase instance = RocketLauncherDatabase._();

  static Database? _database;

  RocketLauncherDatabase._();

  Future<Database> getDatabase() async {
    Database? database = _database;
    if (database == null) {
      database = await _initDatabase();
    }
    _database = database;
    return database;
  }

  void closeDatabase() {
    Database? database = _database;
    if (database != null) {
      database.close();
    }
    _database = null;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "rocket_launcher.db");
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database database, int version) async {
    await database.execute(RocketsDatabaseSqflite.CREATE_TABLE);
    await database.execute(LaunchesDatabaseSqflite.CREATE_TABLE);
  }
}
