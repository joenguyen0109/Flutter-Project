import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:simple_money_manager/Business_logic/bloc/handleStateToWdiget.dart';
import 'package:simple_money_manager/representation/Widget/AppBarWidget.dart';

import 'BottomNavigationBarWidget.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Main widget get rebuild');
    return Scaffold(
      // Bar on top to select mont
      appBar: AppBarWidget(),
      // Bar on top to select month

      //Body
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return mainBlocStateToWidget(state);
        },
      ),

      //Body

      // Float action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<MainBloc>().add(AddTransactionPageEvent()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 5.0,
      ),
      // Float action button

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
