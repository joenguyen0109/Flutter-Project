import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/bloc/UpdateIncomeBloc/UpdateIncomeBloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/AppBar/appbar_cubit.dart';
import 'package:simple_money_manager/Business_logic/cubit/BottomNavigationCubit/BottomNavigationCubit.dart';
import 'package:simple_money_manager/Data/Model/Failure.dart';
import 'package:simple_money_manager/Data/Repository/DataAPI.dart';
import 'package:simple_money_manager/representation/Pages/AddTransactionPage.dart';
import 'package:simple_money_manager/representation/Pages/IconPage.dart';
import 'package:simple_money_manager/representation/Widget/MainWidget.dart';
import 'package:sqflite/sqflite.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DataAPI dataRepository;
  final BottomnavigationCubit bottomnavigationCubit;
  final AppbarCubit appbarCubit;
  final UpdateIncomeBloc formControl;
  StreamSubscription appbarCubitSubscription;
  StreamSubscription bottomnavigationbarSubscription;
  StreamSubscription formControlSubscription;
  MainBloc({
    @required this.bottomnavigationCubit,
    @required this.appbarCubit,
    @required this.formControl,
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

    formControlSubscription = formControl.stream.listen(
      (state) {
        if (state is SuccessfullState) {
          this.add(TransactionPageEvent());
        }
      },
    );
  }
  var newtransaction = {};
  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    try {
      if (event is TransactionPageEvent) {
        yield LoadingState();
        //var data = await DataAPI.getAllTransactions();
        print('TransactionPage build');

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
      } else if (event is CategoryPageEvent) {
        yield LoadingState();
        var data = await dataRepository.getExpenseByCategory(
          appbarCubit.time.month,
          appbarCubit.time.year,
        );
        yield CategoryPageState(data: data);
      } else if (event is AddTransactionPageEvent) {
        var category = await dataRepository.getListCategory();
        Get.to(() => AddTransactionPage(category: category));
      } else if (event is IconPageEvent) {
        newtransaction = formatValidate(
            title: event.name,
            amount: event.spend,
            date: event.time,
            category: event.category);

        final listPath =
            await dataRepository.getIcon(event.category.toString());
        Get.to(() => IconPage(path: listPath));
      } else if (event is AddTransactionToDataBaseEvent) {
        await dataRepository.insertData(
          newtransaction['title'],
          newtransaction['amount'],
          newtransaction['category'],
          newtransaction['date'],
        );
        Get.offAll(() => MainWidget());
        this.add(TransactionPageEvent());
      }
    } on DatabaseException {
      Get.snackbar('Error', 'Error in database');
      Get.offAll(() => MainWidget());
      yield ErrorState(message: 'There are errors with the database');
    } on Failure catch (error) {
      Get.snackbar('Error', error.message);
    } catch (e) {
      yield ErrorState(message: 'Something goes wrong');
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

  @override
  Future<void> close() {
    bottomnavigationbarSubscription.cancel();
    appbarCubitSubscription.cancel();
    formControlSubscription.cancel();
    return super.close();
  }
}
