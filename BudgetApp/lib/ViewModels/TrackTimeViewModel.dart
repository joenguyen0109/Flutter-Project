import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackTimeViewModel with ChangeNotifier {
  var month = new DateFormat.MMMM().format(new DateTime.now());
  var time = new DateTime.now();
  var display = new DateFormat.yMMMM().format(new DateTime.now());
  void leftClick() {
    if (time.month == 1) {
      time = new DateTime(time.year - 1, 12);
    } else {
      time = new DateTime(time.year, time.month - 1);
    }
    month = new DateFormat.MMMM().format(time);
    display = new DateFormat.yMMMM().format(time);
    notifyListeners();
  }

  void rightClick() {
    if (time.month == 12) {
      time = new DateTime(time.year + 1, 1);
    } else {
      time = new DateTime(time.year, time.month + 1);
    }
    month = new DateFormat.MMMM().format(time);
    display = new DateFormat.yMMMM().format(time);
    notifyListeners();
  }
}
