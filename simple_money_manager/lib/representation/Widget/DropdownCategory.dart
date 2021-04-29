import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/DropDownCubit/dropdown_cubit.dart';

class DropdownCategoryWidget extends StatelessWidget {
  final listCategory;

  DropdownCategoryWidget({
    @required this.listCategory,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit, String>(builder: (context, state) {
      return Container(
        alignment: Alignment.topLeft,
        child: DropdownButton<String>(
          hint: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Select Item Type",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          value: state,
          onChanged: (var value) =>
              context.read<DropdownCubit>().onChanged(value),
          items: listCategory
              .map<DropdownMenuItem<String>>(
                (category) => DropdownMenuItem<String>(
                  value: category,
                  child: Container(
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
