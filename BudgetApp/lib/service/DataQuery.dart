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
    // print("output: ");
    // mapTranscation.forEach((key, value) {
    //   print("Day: "+key);
    //   value.forEach((element) {
    //     print(element.name + " " + element.spend.toString());
    //   });
    // });
    return mapTranscation;
  }

  Future<void> insertToDataBase({
    String name,
    String spend,
    String date,
    String category,
  }) async {
    try {
      await dbHelper.insertData(
          name: name.isEmpty ? null : name,
          spend: _validSpend(spend),
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
