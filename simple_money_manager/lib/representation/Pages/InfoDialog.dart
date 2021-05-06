import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_money_manager/representation/Widget/ConfirmDeleteWidget.dart';

class InforDialog extends StatelessWidget {
  final transaction;
  InforDialog({@required this.transaction});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_rounded),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Image.asset(transaction.iconPath),
              ),
              ListTile(
                leading: Icon(Icons.title),
                title: Text(transaction.name),
              ),
              ListTile(
                leading: Icon(Icons.money_rounded),
                title: Text(transaction.spend.toString()),
              ),
              ListTile(
                leading: Icon(Icons.category_sharp),
                title: Text(transaction.category),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(transaction.time.day.toString() +
                    "/" +
                    transaction.time.month.toString() +
                    "/" +
                    transaction.time.year.toString()),
              ),
              Container(
                alignment: Alignment.bottomRight,
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () =>
                      Get.dialog(ConfirmDeleteWidget(id: transaction.id)),
                  elevation: 5.0,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
