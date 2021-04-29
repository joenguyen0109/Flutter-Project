part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class TransactionPageEvent extends MainEvent {}

class IconPageEvent extends MainEvent {
  final name;
  final spend;
  final time;
  final category;
  IconPageEvent({
    @required this.name,
    @required this.spend,
    @required this.time,
    @required this.category,
  });
}

class AddTransactionToDataBaseEvent extends MainEvent {}

class CategoryPageEvent extends MainEvent {}

class AddTransactionPageEvent extends MainEvent {}

class DeleteTransactionEvent extends MainEvent {}
