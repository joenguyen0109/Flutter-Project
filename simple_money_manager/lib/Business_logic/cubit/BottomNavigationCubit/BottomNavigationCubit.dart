import 'package:bloc/bloc.dart';

class BottomnavigationCubit extends Cubit<int> {
  BottomnavigationCubit() : super(0);
  int currentPage = 0;
  void changePage(int index) {
    currentPage = index;
    emit(index);
  }
}
