import 'package:flutter/material.dart';
import '../service/locator.dart';
import '../service/DataQuery.dart';

class TrackViewModel with ChangeNotifier {
  var service = locator<Dataquery>();
  List<Map<dynamic, dynamic>> _data = [];
  List<Map<dynamic, dynamic>> get data => _data;
  var _total = [];
  Future<void> fetchData({int month, int year}) async {
    _data = await service.getSpendCategory(month: month, year: year);
    _total = await service.getTotalByMonth(month: month, year: year);
  }

  int getTotal() {
    return _total[0]['sum'];
  }
}
