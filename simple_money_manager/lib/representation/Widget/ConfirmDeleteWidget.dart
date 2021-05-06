import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MainWidget.dart';

class ConfirmDeleteWidget extends StatelessWidget {
  final id;
  ConfirmDeleteWidget({@required this.id});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Transaction'),
      content: Text(
          'Do you really want to delete item?'), // Message which will be pop up on the screen
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            Get.offAll(() => MainWidget());
            context.read<MainBloc>().add(
                  DeleteTransaction(id: id),
                );
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
