import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/cubit/AppBar/appbar_cubit.dart';
import 'package:simple_money_manager/Business_logic/cubit/BottomNavigationCubit/BottomNavigationCubit.dart';
import 'package:simple_money_manager/Data/Model/Failure.dart';
import 'package:simple_money_manager/Data/Repository/DataAPI.dart';
import 'package:simple_money_manager/representation/Pages/AddTransactionPage.dart';
import 'package:simple_money_manager/representation/Pages/IconPage.dart';
import 'package:simple_money_manager/representation/Widget/MainWidget.dart';
import 'package:sqflite/sqflite.dart';

import '../handleStateToWdiget.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DataAPI dataRepository;
  final BottomnavigationCubit bottomnavigationCubit;
  final AppbarCubit appbarCubit;

  var _newtransaction = {};

  StreamSubscription appbarCubitSubscription;
  StreamSubscription bottomnavigationbarSubscription;

  MainBloc({
    @required this.bottomnavigationCubit,
    @required this.appbarCubit,
    @required this.dataRepository,
  }) : super(LoadingState()) {
    bottomnavigationbarSubscription =
        bottomnavigationCubit.stream.listen((state) {
      if (state == 0) {
        this.add(TransactionPageEvent());
      } else {
        this.add(CategoryPageEvent());
      }
    });

    appbarCubitSubscription = appbarCubit.stream.listen((state) {
      if (bottomnavigationCubit.currentPage == 0) {
        this.add(TransactionPageEvent());
      } else {
        this.add(CategoryPageEvent());
      }
    });
  }

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    try {
// TransactionPageEvent
      if (event is TransactionPageEvent) {
        yield LoadingState();

        var data = await dataRepository.getTrasactionsByTime(
            appbarCubit.time.month, appbarCubit.time.year);
        var income = await dataRepository.getIncomeByMonth(
          appbarCubit.time.month,
          appbarCubit.time.year,
        );
        var expense = await dataRepository.getExpenseByMonth(
          appbarCubit.time.month,
          appbarCubit.time.year,
        );
        yield TransactionPageState(
          data: data,
          income: income,
          expense: expense,
          balance: income - expense,
        );
// TransactionPageEvent

// CategoryPageEvent
      } else if (event is CategoryPageEvent) {
        yield LoadingState();
        var data = await dataRepository.getExpenseByCategory(
          appbarCubit.time.month,
          appbarCubit.time.year,
        );
        yield CategoryPageState(data: data);
// CategoryPageEvent

//AddTransactionPageEvent
      } else if (event is AddTransactionPageEvent) {
        var category = await dataRepository.getListCategory();
        Get.to(() => AddTransactionPage(category: category));
//AddTransactionPageEvent

//InconPageEvent
      } else if (event is IconPageEvent) {
        _newtransaction = formatValidate(
            title: event.name,
            amount: event.spend,
            date: event.time,
            category: event.category);

        final listPath =
            await dataRepository.getIcon(event.category.toString());
        Get.to(() => IconPage(path: listPath));
//InconPageEvent

//UpdateIncomeToDataBase
      } else if (event is UpdateIncomeToDataBase) {
        await dataRepository.insertIncome(
          handleForm(event.income),
          appbarCubit.time.month,
          appbarCubit.time.year,
        );
        Get.back();
        this.add(TransactionPageEvent());
//UpdateIncomeToDataBase

//AddTransactionToDataBaseEvent
      } else if (event is AddTransactionToDataBaseEvent) {
        await dataRepository.insertNewTransaction(
          _newtransaction['title'],
          _newtransaction['amount'],
          _newtransaction['category'],
          _newtransaction['date'],
          event.icon,
        );
        Get.offAll(() => MainWidget());
        this.add(TransactionPageEvent());
//AddTransactionToDataBaseEvent

//DeleteTransaction
      } else if (event is DeleteTransaction) {
        await dataRepository.deleteTransaction(event.id);
        Get.back();
        this.add(TransactionPageEvent());
      }
//DeleteTransaction

// Hanlde error
    } on DatabaseException {
      // Get.offAll(() => MainWidget());
      showToastMessage('something wrong with database');
    } on Failure catch (error) {
      showToastMessage(error.message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  formatValidate({
    @required String title,
    @required String amount,
    @required String date,
    @required String category,
  }) {
    if (title.isEmpty || amount.isEmpty || date.isEmpty || category.isEmpty) {
      throw Failure(message: 'Please complete all the field');
    }
    try {
      double.parse(amount);
    } catch (e) {
      throw Failure(message: 'Please enter a valid amount');
    }
    return {
      'title': title,
      'amount': double.parse(amount),
      'date': DateTime.parse(date),
      'category': category,
    };
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

  @override
  Future<void> close() {
    bottomnavigationbarSubscription.cancel();
    appbarCubitSubscription.cancel();
    return super.close();
  }
}
