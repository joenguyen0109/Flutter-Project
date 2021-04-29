part of 'UpdateIncomeBloc.dart';

abstract class UpdateIncomeBlocEvent extends Equatable {
  const UpdateIncomeBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateIncomeEvent extends UpdateIncomeBlocEvent {
  final data;
  final month;
  final year;

  UpdateIncomeEvent({
    @required this.data,
    @required this.month,
    @required this.year,
  });
}
