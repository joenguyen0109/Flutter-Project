import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/* THIS CLASS IS USED TO CREATE THE DATABASE AND TABLES*/

class DataBaseClass {
  static final databaseName = "database.db";
  static final transactionTable = "transcation_table";
  static final incomeTable = "Income_table";
  static final iconTable = "icon_table";

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnSpend = 'spend';
  static final columnCategory = 'category';
  static final columnDay = 'day';
  static final columnMonth = 'month';
  static final columnYear = 'year';
  static final columnIncome = 'income';
  static final columnPath = 'path';

  // Create a singleton
  DataBaseClass._();

  static final DataBaseClass instance = DataBaseClass._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    // If database doesnt exist, create one
    _database = await initDB();
    return _database;
  }

  // Create new database
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create new tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $transactionTable (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnSpend REAL NOT NULL,
            $columnCategory TEXT NOT NULL,
            $columnDay INTEGER NOT NULL,
            $columnMonth INTEGER NOT NULL,
            $columnYear INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $incomeTable (
            $columnId INTEGER PRIMARY KEY,
            $columnIncome INTEGER NOT NULL CHECK ($columnIncome > 0),
            $columnMonth INTEGER NOT NULL,
            $columnYear INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $iconTable (
            $columnId INTEGER PRIMARY KEY,
            $columnCategory TEXT NOT NULL,
            $columnPath TEXT NOT NULL
          )
          ''');

    // Add the icon
    final String response = await rootBundle.loadString('icon/icon.json');
    final data = await json.decode(response);
    final keys = data.keys;
    for (var key in keys) {
      for (var path in data[key]) {
        await db.insert(
          iconTable,
          {
            columnCategory: key,
            columnPath: path,
          },
        );
      }
    }
  }
}
