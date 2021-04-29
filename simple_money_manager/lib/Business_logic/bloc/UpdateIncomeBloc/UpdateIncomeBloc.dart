import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Data/Model/Failure.dart';
import 'package:simple_money_manager/Data/Repository/UpdateIncomeAPI.dart';
import 'package:sqflite/sqflite.dart';
part 'UpdateIncome_event.dart';
part 'UpdateIncome_state.dart';

class UpdateIncomeBloc
    extends Bloc<UpdateIncomeBlocEvent, UpdateIncomeBlocState> {
  final UpdateIncomeAPI dataRepository;
  UpdateIncomeBloc({
    @required this.dataRepository,
  }) : super(FormcontrolblocInitial());

  @override
  Stream<UpdateIncomeBlocState> mapEventToState(
    UpdateIncomeBlocEvent event,
  ) async* {
    if (event is UpdateIncomeEvent) {
      try {
        yield LoadingState();

        await dataRepository.insertIncome(
          handleForm(event.data),
          event.month,
          event.year,
        );
        Get.back();
        yield SuccessfullState();
      } on Failure catch (error) {
        Get.snackbar(
          "Error",
          error.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } on DatabaseException {
        if (handleForm(event.data) == 0) {
          Get.snackbar(
            "Error",
            'Income can not be 0',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }
  }

  int handleForm(String data) {
    int datareturn = 0;
    if (data.isEmpty) {
      throw Failure(message: 'Field can not be empty');
    }
    try {
      datareturn = int.parse(data);
    } catch (e) {
      throw Failure(message: 'Field only takes number');
    }
    return datareturn;
  }
}
