part of 'appbar_cubit.dart';

abstract class AppbarState extends Equatable {
  const AppbarState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AppbarInitial extends AppbarState {
  DateTime time;
  AppbarInitial(this.time);
}
