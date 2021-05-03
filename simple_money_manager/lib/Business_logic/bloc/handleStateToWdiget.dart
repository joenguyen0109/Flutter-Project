import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_money_manager/Business_logic/bloc/MainBloc/main_bloc.dart';
import 'package:simple_money_manager/representation/Pages/CategoryPage.dart';
import 'package:simple_money_manager/representation/Pages/HomePage.dart';

mainBlocStateToWidget(MainState state) {
  if (state is LoadingState) {
    return Text('Loading');
  } else if (state is TransactionPageState) {
    return TransactionsPage(state: state);
  } else if (state is CategoryPageState) {
    return CategoryPage(data: state.data);
  } else if (state is ErrorState) {
    return Center(
      child: Text(state.message),
    );
  }
}

dataToColumnWidget(var data, BuildContext context) {
  final formatCurrency = new NumberFormat("#,##0", "en_US");
  List<Widget> listWidget = [];
  data.forEach((k, v) => {
        for (var transaction in v)
          {
            listWidget.add(
              Container(
                padding: EdgeInsets.all(3),
                child: ListTile(
                  onLongPress: () {
                    print(transaction.id);
                  },
                  onTap: () => print(transaction.id),
                  leading: Image(
                    image: AssetImage(transaction.iconPath),
                    height: MediaQuery.of(context).size.height / 23,
                  ),
                  title: Text(
                    transaction.name,
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Text(
                    "-${formatCurrency.format(transaction.spend)}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          }
      });
  return Column(
    children: listWidget,
  );
}
