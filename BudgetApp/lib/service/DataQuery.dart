import 'package:flutter/cupertino.dart';

import '../DataBase/Database.dart';
import '../Model/TranscationModel.dart';

class Dataquery with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  Map<String, List<Transaction>> _list = {};
  Map<String, List<Transaction>> get list => _list;



  Future<void> getData({int month, int year}) async {
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
    print("output: ");
    mapTranscation.forEach((key, value) {
      print(key);
      value.forEach((element) {
        print(element.name + " " + element.day.toString());
      });
    });
    _list =  mapTranscation;
  }

  Future<void> setValue({
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
    var Date = "";
    for (var i = 2; i > -1; i--) {
      if (i == 2 && int.parse(listDigits[i]) < 2020) {
        return null;
      }
      if (i != 0) {
        Date += listDigits[i] + '-';
      } else {
        Date += listDigits[i];
      }
    }
    return Date;
  }

  void prints() async {
    var data = await dbHelper.queryAllRows();
    print('output');
    data.forEach((element) {
      print(element);
    });
  }
}
