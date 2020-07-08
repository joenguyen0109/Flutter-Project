import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeViewModel with ChangeNotifier {
  String _month = new DateFormat.MMMM().format(new DateTime.now());
  String get month => _month;


}
