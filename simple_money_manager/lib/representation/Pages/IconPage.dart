import 'package:drag_select_grid_view/drag_select_grid_view.dart';
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
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_forward_outlined),
                onPressed: () {
                  context.read<MainBloc>().add(
                        AddTransactionToDataBaseEvent(),
                      );
                  context.read<DropdownCubit>().onChanged(null);
                }),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: DragSelectGridView(
            itemCount: path.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, index, isSelected) {
              print('run');
              return Container(
                child: Image.asset(path[index]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]
                      : [],
                ),
              );
            },
          )),
    );
  }
}
