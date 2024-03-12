//! Handling  our DataBase

import 'package:get/get.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/data/static_date.dart';

class DbController extends GetxController {
  static const _dbName = 'maroro.db';
  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      version: 1,
      dbPath,
      onCreate: (db, version) {
        _createTable(db, 'users', '''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            password TEXT NOT NULL,
            type TEXT,
            allow INTEGER NOT NULL
          );
        ''');

        _createTable(db, 'drivers', '''
          CREATE TABLE IF NOT EXISTS drivers (
            id INTEGER PRIMARY KEY ,
            name TEXT NOT NULL,
            photo BLOB, -- Store photo as binary data
            city TEXT,
            license TEXT
          );
        ''');

        _createTable(db, 'cars', '''
          CREATE TABLE IF NOT EXISTS cars (
            number TEXT PRIMARY KEY ,
            model TEXT NOT NULL,
            owner_id INTEGER NOT NULL,
            FOREIGN KEY (owner_id) REFERENCES drivers(id) ON DELETE CASCADE
          );
        ''');

        _createTable(db, 'types', '''
          CREATE TABLE IF NOT EXISTS types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            cost DOUBLE
          );
        ''');

        _createTable(db, 'violations', '''
          CREATE TABLE IF NOT EXISTS violations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date DATE NOT NULL,
            type_id INTEGER NOT NULL,
            note TEXT,
            loction TEXT,
            car_number TEXT,
            user_id INTEGER,
            FOREIGN KEY (type_id) REFERENCES types(id) ON DELETE CASCADE,
            FOREIGN KEY (car_number) REFERENCES cars(number) ON DELETE CASCADE,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          );
        ''');
      },
    );
  }

  void _createTable(Database db, String tableName, String createTableSql) {
    db.execute(createTableSql);
  }

  @override
  void onInit() async {
    await _initDb();

    Get.put(InitStaticDate());

    super.onInit();
  }
}

// readData(String sql) async {
//   Database? myDb = await db;
//   List<Map> response = await myDb.rawQuery(sql);
//   return response;
// }

// insertData(String sql) async {
//   Database? myDb = await db;
//   int response = await myDb.rawInsert(sql);
//   return response;
// }

// updateData(String sql) async {
//   Database? myDb = await db;
//   int response = await myDb.rawUpdate(sql);
//   return response;
// }

// deletetData(String sql) async {
//   Database? myDb = await db;
//   int response = await myDb.rawDelete(sql);
//   return response;
// }
