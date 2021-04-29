part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class InitialState extends MainState {}

class LoadingState extends MainState {}

class TransactionPageState extends MainState {
  final List<dynamic> data;
  final income;
  final expense;
  final balance;
  TransactionPageState({
    @required this.data,
    @required this.income,
    @required this.expense,
    @required this.balance,
  });
}

class CategoryPageState extends MainState {
  final List<dynamic> data;
  CategoryPageState({@required this.data});
}

class AddTransactionState extends MainState {}

class ErrorState extends MainState {
  final message;
  ErrorState({@required this.message});
}
