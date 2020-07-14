import 'package:BudgetApp/service/DataQuery.dart';
import 'package:BudgetApp/service/locator.dart';
import 'package:flutter/cupertino.dart';
import '../Model/TranscationModel.dart';

class HomeViewModel with ChangeNotifier {
  var service = locator<Dataquery>();
  Map<String, List<Transaction>> _data = {};
  Map<String, List<Transaction>> get data => _data;
  int _income = 30000000;
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
    _data = await service.getData(month: month, year: year);
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
        date: date,
        category: category,
      );
      await fetchData();
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
}
