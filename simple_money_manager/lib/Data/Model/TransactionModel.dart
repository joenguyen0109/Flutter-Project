import 'package:simple_money_manager/data/Database/database.dart';

class Transaction {
  int id;
  String name;
  double spend;
  String category;
  DateTime time;
  Transaction({
    this.id,
    this.name,
    this.spend,
    this.category,
    this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
        id: json["id"],
        name: json["name"],
        spend: json["spend"],
        category: json["category"],
        time: DateTime.utc(
          json["year"],
          json["month"],
          json["day"],
        ),
      );

  Map<String, dynamic> toJson() => {
        DataBaseClass.columnId: id,
        DataBaseClass.columnName: name,
        DataBaseClass.columnSpend: spend,
        DataBaseClass.columnCategory: category,
        DataBaseClass.columnDay: time.day,
        DataBaseClass.columnMonth: time.month,
        DataBaseClass.columnYear: time.year,
      };
}
