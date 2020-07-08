

class Transaction {
  int _id;
  String _name;
  int _spend;
  String _category;
  int _day;
  int _month;
  int _year;

  Transaction({
    int id,
    String name,
    int spend,
    String category,
    int day,
    int month,
    int year,
  }) {
    this._id = id;
    this._name = name;
    this._spend = spend;
    this._category = category;
    this._day = day;
    this._month = month;
    this._year = year;
  }

  String get name =>  this._name;
  int get spend => this._spend;
  String get category => this._category;
  int get day =>  this._day;
  int get month =>  this._month;
  int get year => this._year;
  int get id => this._id;

}
