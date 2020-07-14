import 'package:BudgetApp/service/DataQuery.dart';
import 'package:BudgetApp/service/locator.dart';
import 'package:flutter/cupertino.dart';
import '../Model/TranscationModel.dart';

class HomeViewModel with ChangeNotifier {
  var service = locator<Dataquery>();
  int _month = 0;
  int _year = 0;
  Map<String, List<Transaction>> _data = {};
  Map<String, List<Transaction>> get data => _data;
  int _income = 0;
  int get income => _income;

  int totalSpend() {
    int spend = 0;
    _data.forEach((key, value) {
      value.forEach((element) {
        spend += element.spend;
      });
    });
    return spend;
  }

  Future<void> fetchData({int month, int year}) async {
    _month = month;
    _year = year;
    _data = await service.getData(month: month, year: year);
    var income = await service.getIncome(month: month, year: year);
    if (income.isEmpty) {
      _income = 0;
    } else {
      _income = income[0]['income'];
    }
  }

  Future<void> addNewTrans({
    String name,
    String spend,
    String date,
    String category,
  }) async {
    try {
      await locator<Dataquery>().insertToDataBase(
        name: name,
        spend: spend,
        income: _income,
        date: date,
        category: category,
      );
      await fetchData();
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  void setIncome(int income) {
    _income = income;
    notifyListeners();
  }

  Future<void> updateIncome({String income}) async {
    try {
      var i = await service.updateIncome(
          income: income, month: _month, year: _year);
      setIncome(i);
    } catch (e) {
      throw e;
    }
  }

  Future<void> addNewIncome({String income}) async {
    try {
      var i = await service.insertIncome(
          income: income, month: _month, year: _year);
      setIncome(i);
    } catch (e) {
      throw e;
    }
  }
}
