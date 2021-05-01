import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/DropDownCubit/dropdown_cubit.dart';

class IconPage extends StatelessWidget {
  final path;
  IconPage({@required this.path});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            children: path.map<InkWell>((value) {
              return InkWell(
                // highlightColor: null,
                onTap: () {
                  context.read<MainBloc>().add(
                        AddTransactionToDataBaseEvent(icon: value),
                      );
                  context.read<DropdownCubit>().onChanged(null);
                },

                child: Image.asset(value),
              );
            }).toList(),
          )),
    );
  }
}
