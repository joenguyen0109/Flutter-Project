import 'package:BudgetApp/service/DataQuery.dart';
import 'package:BudgetApp/service/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../Model/TranscationModel.dart';

class HomeViewModel extends ChangeNotifier {
  String _month = new DateFormat.MMMM().format(new DateTime.now());
  String get month => _month;
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

  Future<void> fetchData() async {
    _data = await service.getData(month: 7, year: 2020);
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
