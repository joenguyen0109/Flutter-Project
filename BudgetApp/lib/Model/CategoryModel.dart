import 'package:flutter/material.dart';

class Category {
  const Category(this._name, this._icon, this._color);
  final String _name;
  final Icon _icon;
  final Color _color;

  Icon get icon => _icon;
  Color get color => _color;
  String get name => _name;
}

class CategoryGetter {
  static List<Category> users = <Category>[
    const Category('Shopping', Icon(Icons.arrow_back), Colors.yellow),
    const Category('Grocery', Icon(Icons.arrow_back), Colors.green),
    const Category('Education', Icon(Icons.arrow_back), Colors.blue),
    const Category('Others', Icon(Icons.arrow_back), Colors.grey),
  ];

  static Icon getIcon(String category) {
    var index = users.indexWhere((element) => element.name == category);
    return users[index].icon;
  }

  static Color getColor(String category) {
    var index = users.indexWhere((element) => element.name == category);
    return users[index].color;
  }

  static bool alreayExist(String category) {
    return users.any((element) => element.name == category);
  }
}
