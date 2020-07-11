import 'package:BudgetApp/Views/AddNewCategory.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TrackView extends StatefulWidget {
  @override
  _TrackViewState createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'July - 2020',
                    style: TextStyle(
                      fontFamily: 'Sriracha',
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (BuildContext ctx) => NewCategory(),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Shopping'),
                          LinearPercentIndicator(
                            alignment: MainAxisAlignment.end,
                            width: MediaQuery.of(context).size.width - 20,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 0.8,
                            center: Text("80.0%"),
                            linearStrokeCap: LinearStrokeCap.round,
                            progressColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
