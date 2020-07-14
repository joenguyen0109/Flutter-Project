import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'transcation_table';
  static final table2 = 'category_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnSpend = 'spend';
  static final columnCategory = 'category';
  static final columnDate = 'date';
  static final columnDay = 'day';
  static final columnMonth = 'month';
  static final columnYear = 'year';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnSpend INTEGER NOT NULL,
            $columnCategory TEXT NOT NULL,
            $columnDate TEXT NOT NULL CHECK (DATE($columnDate) IS NOT NULL),
            $columnDay INTEGER NOT NULL,
            $columnMonth INTEGER NOT NULL,
            $columnYear INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertData({
    String name,
    int spend,
    String category,
    String date,
  }) async {
    Database db = await instance.database;
    var dates = date.split("-");

    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnSpend: spend,
      DatabaseHelper.columnCategory: category,
      DatabaseHelper.columnDate: date,
      DatabaseHelper.columnDay: int.parse(dates[2].toString()),
      DatabaseHelper.columnMonth: int.parse(dates[1].toString()),
      DatabaseHelper.columnYear: int.parse(dates[0].toString()),
    };
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Map<String, dynamic>>> queryDataByMonth(
      {int month, int year}) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT name, spend, category, day, month, year FROM $table WHERE month == $month AND year == $year ORDER BY month DESC, date DESC, spend DESC');
  }

  Future<List<Map<dynamic, dynamic>>> queryBaseOnCategory(
      {int month, int year}) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT $columnCategory, SUM($columnSpend) as catTotal FROM $table WHERE $columnMonth == $month AND $columnYear == $year GROUP BY $columnCategory ORDER BY SUM($columnSpend) DESC');
  }

  Future<List<Map<dynamic, dynamic>>> queryTotalonMonth(
      {int month, int year}) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT SUM($columnSpend) as sum FROM $table WHERE $columnMonth == $month AND $columnYear == $year');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
