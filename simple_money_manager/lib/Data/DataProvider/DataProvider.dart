import 'package:simple_money_manager/Data/Database/database.dart';
import 'package:simple_money_manager/Data/Model/IncomeModel.dart';
import 'package:simple_money_manager/Data/Model/TransactionModel.dart';

class DataBaseQueryProvider {
  // get instance of database class
  var _databaseclass;

  DataBaseQueryProvider(this._databaseclass);

  insertNewTransaction(Transaction newTransaction) async {
    // Access to the database
    final db = await _databaseclass.database;
    var result = await db.insert(
      DataBaseClass.transactionTable,
      newTransaction.toJson(),
    );
    return result;
  }

  addNewIncome(Income newIncome) async {
    final db = await _databaseclass.database;
    var result = await db.insert(
      DataBaseClass.incomeTable,
      newIncome.toJson(),
    );
    return result;
  }

  upDateTransaction(Transaction newTransaction) async {
    final db = await _databaseclass.database;
    await db.update(
      DataBaseClass.transactionTable,
      newTransaction.toJson(),
      where: "id = ?",
      whereArgs: [newTransaction.id],
    );
  }

  upDateIncome(int income, int month, int year) async {
    final db = await _databaseclass.database;
    var incomeInfo = await db.query(
      DataBaseClass.incomeTable,
      where: 'month = ? AND year = ? ',
      whereArgs: [
        month,
        year,
      ],
    );
    Income incomeMonth =
        incomeInfo.map((item) => Income.fromJson(item)).toList()[0];
    var json = incomeMonth.toJson();
    json['income'] = income;
    await db.update(
      DataBaseClass.incomeTable,
      json,
      where: "id = ?",
      whereArgs: [incomeMonth.id],
    );
  }

  deleteTransaction(int id) async {
    final db = await _databaseclass.database;
    await db.delete(
      DataBaseClass.transactionTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  getIncomeByMonth(int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.query(
      DataBaseClass.incomeTable,
      where: 'month = ? AND year = ? ',
      whereArgs: [
        month,
        year,
      ],
    );
    return result.isNotEmpty
        ? result.map((item) => Income.fromJson(item)).toList()[0].income
        : 0;
  }

  getExpenseByMonth(int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.rawQuery(
        "SELECT ${DataBaseClass.columnSpend} AS SPEND FROM ${DataBaseClass.transactionTable} WHERE MONTH = $month AND YEAR +$year");
    double total = 0;
    result.map((item) => item['SPEND']).toList().forEach((element) => {
          total += element,
        });
    return result.isNotEmpty ? total : 0;
  }

  getExpenseByCategory(int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.rawQuery(
        'SELECT category ,SUM(spend) as SPEND  FROM ${DataBaseClass.transactionTable} WHERE month = $month AND year = $year GROUP BY category ORDER BY spend desc');
    return result.isNotEmpty ? result.toList() : [];
  }

  getPatternCategory(String pattern) async {
    final db = await _databaseclass.database;

    String queryCommand =
        "SELECT DISTINCT ${DataBaseClass.columnCategory} FROM ${DataBaseClass.transactionTable} WHERE ${DataBaseClass.columnCategory} LIKE" +
            " '%" +
            pattern +
            "%'";
    var result = await db.rawQuery(queryCommand);
    return result.isNotEmpty
        ? result.map((item) => item['category']).toList()
        : [];
  }

  getTotoalDayTransaction(int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.rawQuery(
        'SELECT DISTINCT ${DataBaseClass.columnDay} AS COUNT FROM ${DataBaseClass.transactionTable} WHERE MONTH = $month AND YEAR = $year ORDER BY ${DataBaseClass.columnDay} DESC');
    return result;
  }

  getTransaction(int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.query(
      DataBaseClass.transactionTable,
      where: 'month = ? AND year = ? ',
      whereArgs: [
        month,
        year,
      ],
    );
    return result.isNotEmpty
        ? result.map((item) => Transaction.fromJson(item)).toList()
        : [];
  }

  getTransactionByDay(int day, int month, int year) async {
    final db = await _databaseclass.database;
    var result = await db.query(
      DataBaseClass.transactionTable,
      where: 'month = ? AND year = ? AND day = ?',
      whereArgs: [month, year, day],
    );
    return result.isNotEmpty
        ? result.map((item) => Transaction.fromJson(item)).toList()
        : [];
  }

  getIconByCategory(String category) async {
    final db = await _databaseclass.database;
    var result = await db.query(
      DataBaseClass.iconTable,
      where: 'category LIKE ?',
      whereArgs: [category],
    );
    return result.map((item) => item['path']).toList();
  }

  getCategory() async {
    final db = await _databaseclass.database;
    var result = await db.rawQuery(
      'SELECT DISTINCT ${DataBaseClass.columnCategory} FROM  ${DataBaseClass.iconTable} ORDER BY category',
    );
    return result.map((item) => item['category']).toList();
  }

  deleteAllTransactions() async {
    final db = await _databaseclass.database;
    return await db.delete(DataBaseClass.transactionTable);
  }
}
