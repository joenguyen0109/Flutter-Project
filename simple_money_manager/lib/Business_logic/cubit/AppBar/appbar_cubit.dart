import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<String> {
  var time = DateTime.now();
  AppbarCubit() : super(DateFormat.yMMMM().format(DateTime.now()));

  void prevMonth() {
    if (time.month == 1) {
      time = new DateTime(time.year - 1, 12);
    } else {
      time = new DateTime(time.year, time.month - 1);
    }
    emit(DateFormat.yMMMM().format(time));
  }

  void nextMonth() {
    if (time.month == 12) {
      time = new DateTime(time.year + 1, 1);
    } else {
      time = new DateTime(time.year, time.month + 1);
    }

    emit(DateFormat.yMMMM().format(time));
  }
}
