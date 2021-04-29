part of 'UpdateIncomeBloc.dart';

abstract class UpdateIncomeBlocState extends Equatable {
  const UpdateIncomeBlocState();

  @override
  List<Object> get props => [];
}

class FormcontrolblocInitial extends UpdateIncomeBlocState {}

class LoadingState extends UpdateIncomeBlocState {}

class SuccessfullState extends UpdateIncomeBlocState {}
