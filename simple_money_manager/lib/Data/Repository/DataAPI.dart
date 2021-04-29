import 'package:intl/intl.dart';
import 'package:simple_money_manager/Data/DataProvider/DataProvider.dart';
import 'package:simple_money_manager/Data/Database/database.dart';
import 'package:simple_money_manager/Data/Model/TransactionModel.dart';

class DataAPI {
  insertData(
    String name,
    double spend,
    String category,
    DateTime time,
  ) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    await dataProvider.insertNewTransaction(
      Transaction(
        name: name,
        spend: spend,
        category: category,
        time: time,
      ),
    );
  }

  getIcon(String category) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    return await dataProvider.getIconByCategory(category);
  }

  getListCategory() async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    return await dataProvider.getCategory();
  }

  getExpenseByMonth(int month, int year) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    var result = await dataProvider.getExpenseByMonth(month, year);

    return result;
  }

  getExpenseByCategory(int month, int year) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    var totalExpense = await getExpenseByMonth(month, year);
    List<dynamic> list = [];
    if (totalExpense > 0) {
      var result = await dataProvider.getExpenseByCategory(month, year);
      result.forEach((map) => {
            list.add({
              'category': map['category'],
              'spend': map['SPEND'],
              'ratio': map['SPEND'] / totalExpense,
            })
          });
      return list;
    }
    return [];
  }

  getTrasactionsByTime(int month, int year) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);

    // get how many days have data
    var totalDay = await dataProvider.getTotoalDayTransaction(month, year);
    List<Map<List<dynamic>, List<dynamic>>> data = [];

    // run a for loop get data of each day then add them into list
    for (int i = 0; i < totalDay.length; i++) {
      var value = await dataProvider.getTransactionByDay(
          totalDay[i]['COUNT'], month, year);
      var key;
      if (totalDay[i]['COUNT'] == DateTime.now().day &&
          month == DateTime.now().month &&
          year == DateTime.now().year) {
        key = 'Today';
      } else if (totalDay[i]['COUNT'] == DateTime.now().day - 1) {
        key = 'Yesterday';
      } else {
        key = DateFormat.MMMM()
                .format(DateTime.utc(year, month, totalDay[i]['COUNT'])) +
            " " +
            totalDay[i]['COUNT'].toString();
      }
      double spend = 0;
      for (var transaction in value) {
        spend += transaction.spend;
      }
      data.add({
        [key, spend]: value
      });
    }
    print(data);

    return data;
  }

  getIncomeByMonth(int month, int year) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    return await dataProvider.getIncomeByMonth(month, year);
  }

  deleteAllData() async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    await dataProvider.deleteAllTransactions();
  }

  getSuggestions(String pattern) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    var data = await dataProvider.getPatternCategory(pattern);
    return data;
  }

  // static deleteData() async {
  //   final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
  //   await dataProvider.deleteTransaction(id)
  // }
}
