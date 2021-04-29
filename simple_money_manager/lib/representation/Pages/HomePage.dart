import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_money_manager/representation/Widget/DailyTransactions.dart';
import 'package:simple_money_manager/representation/Widget/DisplayBalanceBoxWidget.dart';
import 'package:simple_money_manager/representation/Widget/DisplayIncomeExpenseBoxWidget.dart';

class TransactionsPage extends StatelessWidget {
  final state;
  TransactionsPage({@required this.state});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DisplayBalanceBoxWidget(balance: state.balance),
            DisplayIncomeExpenseBoxWidget(
              income: state.income,
              expense: state.expense,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return DailyTransaction(data: state.data[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
