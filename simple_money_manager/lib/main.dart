import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:simple_money_manager/Business_logic/bloc/UpdateIncomeBloc/UpdateIncomeBloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/AppBar/appbar_cubit.dart';
import 'package:simple_money_manager/Business_logic/cubit/DropDownCubit/dropdown_cubit.dart';
import 'package:simple_money_manager/Data/Repository/DataAPI.dart';
import 'package:simple_money_manager/Data/Repository/UpdateIncomeAPI.dart';
import 'package:simple_money_manager/representation/Widget/MainWidget.dart';
import 'package:simple_money_manager/Business_logic/cubit/BottomNavigationCubit/BottomNavigationCubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BottomnavigationCubit>(
        create: (_) => BottomnavigationCubit(),
      ),
      BlocProvider<AppbarCubit>(
        create: (_) => AppbarCubit(),
      ),
      BlocProvider<UpdateIncomeBloc>(
        create: (_) => UpdateIncomeBloc(dataRepository: UpdateIncomeAPI()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bottomnavigationcubit =
        BlocProvider.of<BottomnavigationCubit>(context);
    final appbarCubit = BlocProvider.of<AppbarCubit>(context);
    final formControlBloc = BlocProvider.of<UpdateIncomeBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (_) => MainBloc(
            bottomnavigationCubit: bottomnavigationcubit,
            appbarCubit: appbarCubit,
            formControl: formControlBloc,
            dataRepository: new DataAPI(),
          )..add(TransactionPageEvent()),
        ),
        BlocProvider<DropdownCubit>(
          create: (_) => DropdownCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'BalsamiqSans',
        ),
        home: MainWidget(),
      ),
    );
  }
}
