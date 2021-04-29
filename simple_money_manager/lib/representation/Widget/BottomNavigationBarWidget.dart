import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/BottomNavigationCubit/BottomNavigationCubit.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<BottomnavigationCubit, int>(
        builder: (BuildContext context, state) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: state,
            onTap: (index) =>
                context.read<BottomnavigationCubit>().changePage(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "",
                  style: new TextStyle(fontSize: 0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text(
                  "",
                  style: new TextStyle(fontSize: 0),
                ),
              ),
            ],

            //Bottom NavigatorBar
          );
        },
      ),
    );
  }
}
