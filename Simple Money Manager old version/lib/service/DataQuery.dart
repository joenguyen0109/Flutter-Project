import '../DataBase/Database.dart';
import '../Model/TranscationModel.dart';

class Dataquery {
  final dbHelper = DatabaseHelper.instance;

  Future<Map<String, List<Transaction>>> getData({int month, int year}) async {
    Map<String, List<Transaction>> mapTranscation = {};
    List<Transaction> listTransaction = new List();
    final data = await dbHelper.queryDataByMonth(month: month, year: year);
    data.forEach(
      (row) => {
        listTransaction.add(new Transaction(
          id: row['id'],
          name: row['name'],
          spend: row['spend'],
          category: row['category'],
          day: row['day'],
          month: row['month'],
          year: row['year'],
        ))
      },
    );
    listTransaction.forEach((element) {
      if (!mapTranscation.containsKey(element.day.toString())) {
        mapTranscation[element.day.toString()] = [element];
      } else {
        mapTranscation[element.day.toString()].add(element);
      }
    });
    return mapTranscation;
  }

  Future<List<Map<dynamic, dynamic>>> getSpendCategory(
      {int month, int year}) async {
    var data = await dbHelper.queryBaseOnCategory(month: month, year: year);
    return data;
  }

  Future<List<Map<dynamic, dynamic>>> getIncome({int month, int year}) async {
    return await dbHelper.queryIncome(month: month, year: year);
  }

  Future<int> insertIncome({String income, int month, int year}) async {
    await dbHelper.insertIncome(
        income: _validSpend(income), month: month, year: year);
    return _validSpend(income);
  }

  Future<int> updateIncome({String income, int month, int year}) async {
    await dbHelper.updateIncome(
        income: _validSpend(income), month: month, year: year);
    return _validSpend(income);
  }

  Future<List<Map<dynamic, dynamic>>> getTotalByMonth(
      {int month, int year}) async {
    var data = await dbHelper.queryTotalonMonth(month: month, year: year);
    return data;
  }

  Future<void> insertToDataBase({
    String name,
    String spend,
    int income,
    String date,
    String category,
  }) async {
    try {
      await dbHelper.insertData(
          name: name.isEmpty ? null : name,
          spend: _validSpend(spend) > income ? null : _validSpend(spend),
          category: category,
          date: _validDate(date));
    } catch (error) {
      throw "Check your input";
    }
  }

  int _validSpend(String spend) {
    var listDigits = spend.split(',');
    int spends = 0;
    for (String digit in listDigits) {
      if (digit == listDigits[0]) {
        spends = int.parse(digit);
      } else {
        spends = spends * 1000 + int.parse(digit);
      }
    }
    return spends;
  }

  String _validDate(String date) {
    var listDigits = date.split('/');
    var d = "";
    for (var i = 2; i > -1; i--) {
      if (i == 2 && int.parse(listDigits[i]) < 2020) {
        return null;
      }
      if (i != 0) {
        d += listDigits[i] + '-';
      } else {
        d += listDigits[i];
      }
    }
    return d;
  }

  void prints() async {
    var data = await dbHelper.queryAllRows();
    print('output');
    data.forEach((element) {
      print(element);
    });
  }
}
