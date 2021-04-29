import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryPage extends StatelessWidget {
  final data;
  CategoryPage({@required this.data});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          // leading: Image(
                          //   // image: AssetImage(CategoryGetter.getImage(
                          //   //     model.data[index]['category'])),
                          //   height:
                          //       MediaQuery.of(context).size.height / 23,
                          // ),
                          title: Text('${data[index]['category']}'),
                          trailing: Text(
                            "-\$${data[index]['spend']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 30.0,
                          animationDuration: 2500,
                          percent: data[index]['ratio'],
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor:
                              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                  .withOpacity(1.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
