import 'package:md_tarefas/model/tarefa.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _dbName = 'md_tarefas.db';
  static const _dbVersion = 1;

  DatabaseProvider._init();

  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = '${databasePath}/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Tarefa.tableName} (
        ${Tarefa.campoId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Tarefa.campoDescricao} TEXT NOT NULL
        ${Tarefa.campoPrazo} TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int version, int newVersion) async {

  }

}

