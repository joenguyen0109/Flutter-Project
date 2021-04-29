import 'package:flutter/cupertino.dart';
import 'package:simple_money_manager/Data/Database/database.dart';

class Income {
  int id;
  int income;
  int month;
  int year;
  Income({
    this.id,
    @required this.income,
    @required this.month,
    @required this.year,
  });

  factory Income.fromJson(Map<String, dynamic> json) => new Income(
        id: json["id"],
        income: json["income"],
        month: json['month'],
        year: json['year'],
      );

  Map<String, dynamic> toJson() => {
        DataBaseClass.columnId: id,
        DataBaseClass.columnIncome: income,
        DataBaseClass.columnMonth: month,
        DataBaseClass.columnYear: year,
      };
}
