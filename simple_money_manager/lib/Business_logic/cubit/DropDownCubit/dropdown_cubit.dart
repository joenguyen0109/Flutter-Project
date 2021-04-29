import 'package:bloc/bloc.dart';

class DropdownCubit extends Cubit<String> {
  DropdownCubit() : super(null);
  String category = '';
  void onChanged(var value) {
    if (value == null) {
      category = '';
    } else {
      category = value;
    }
    emit(value);
  }
}
