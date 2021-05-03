import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_money_manager/Business_logic/bloc/handleStateToWdiget.dart';

class DailyTransaction extends StatelessWidget {
  final data;
  DailyTransaction({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${data.keys.toList()[0][0]}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  '-${data.keys.toList()[0][1]}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          dataToColumnWidget(data, context),
        ],
      ),
    );
  }
}
