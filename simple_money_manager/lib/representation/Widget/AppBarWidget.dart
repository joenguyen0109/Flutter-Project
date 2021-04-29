import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/AppBar/appbar_cubit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppbarCubit, String>(
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          // Bar on top to select month
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () => context.read<AppbarCubit>().prevMonth(),
              ),
              Text(
                state,
                style: TextStyle(
                  fontFamily: 'Sriracha',
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () => context.read<AppbarCubit>().nextMonth(),
              ),
            ],
          ),
          backgroundColor: Colors.amber,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.0);
}
