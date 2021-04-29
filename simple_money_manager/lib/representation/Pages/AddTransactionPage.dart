import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:simple_money_manager/Business_logic/cubit/DropDownCubit/dropdown_cubit.dart';
import 'package:simple_money_manager/representation/Widget/DropdownCategory.dart';

// ignore: must_be_immutable
class AddTransactionPage extends StatelessWidget {
  final category;
  AddTransactionPage({@required this.category});

  final dateController = TextEditingController();

  TextEditingController titleController = new TextEditingController();

  TextEditingController amountController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              context.read<DropdownCubit>().onChanged(null);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_outlined),
              onPressed: () => context.read<MainBloc>().add(
                    IconPageEvent(
                      name: titleController.text,
                      spend: amountController.text,
                      time: dateController.text,
                      category: context.read<DropdownCubit>().category,
                    ),
                  ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Image
            Container(
              // Image
              height: MediaQuery.of(context).size.height / 3.5,
              child: Image(
                image: new AssetImage('asset/image/paying.png'),
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),

            //Image

            Container(
              // Name
              width: double.infinity,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  labelText: 'Title',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // Amount Money
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        //ThousandsFormatter(),
                      ],
                      decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                  Container(
                    // Date
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      inputFormatters: [
                        //DateInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Date',
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030));
                        dateController.text = date.toString().substring(0, 10);
                      },
                    ),
                  ),
                ],
              ),
            ),
            DropdownCategoryWidget(listCategory: category),
          ],
        ),
      )),
    );
  }
}
