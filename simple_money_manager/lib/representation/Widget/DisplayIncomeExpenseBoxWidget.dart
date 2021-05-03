import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_money_manager/representation/Widget/UpdateIncomeWidget.dart';

class DisplayIncomeExpenseBoxWidget extends StatelessWidget {
  final expense;
  final income;

  const DisplayIncomeExpenseBoxWidget({
    Key key,
    @required this.expense,
    @required this.income,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: (MediaQuery.of(context).size.height - 40) / 6,
            child: Card(
              color: Colors.lightBlue,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () => Get.dialog(UpdateIncomeWidget()),
                  contentPadding: EdgeInsets.only(left: 10),
                  title: Text(
                    '$income',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Income',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  leading: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Image(
                      image: new AssetImage('asset/image/income.png'),
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: (MediaQuery.of(context).size.height - 40) / 6,
          width: MediaQuery.of(context).size.width / 2,
          child: Card(
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 2),
                title: Text(
                  '$expense',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'Expense',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Image(
                    image: new AssetImage('asset/image/expense.png'),
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
